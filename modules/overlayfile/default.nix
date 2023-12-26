# https://github.com/nix-community/home-manager/blob/master/modules/files.nix
{ config, lib, pkgs, ... }:
with lib; let
  _cfg = config.environment.overlay;
  cfg = _cfg.users;
  storePath = _cfg.tempStorePath;

  fileType = (import ./file-type.nix { inherit lib pkgs; });
  inherit (import ./lib.nix { inherit lib; }) storeFileName;
  sourceStorePath = file:
    let
      sourcePath = toString file.source;
      sourceName = storeFileName (baseNameOf sourcePath);
    in
      if builtins.hasContext sourcePath
      then file.source
      else builtins.path { path = file.source; name = sourceName; };
in {
  options.environment.overlay = {
    users = mkOption {
      type = types.attrsOf fileType;
      default = {};
      description = "Attribute set of files to link into the user home.";
    };

    tempStorePath = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "A path to store overlay files which is out of Nix store";
    };

    debug = mkEnableOption "Create .overlay-debug file for debugging";
  };

  config = mkIf (cfg != {}) (
    let
      upper_dir = "/tmp/overlay_files_upper";
      work_dir = "/tmp/overlay_files_work";

      mapper = func: mapAttrs' func cfg;
      folder = func: foldlAttrs func {} cfg;
    in {
      assertions = [
        {
          assertion = _cfg != null;
          message = ''
            tempStorePath should not be Null when overlay files is enabled.
          '';
        }
        (let
          dups = attrNames
            (filterAttrs (n: v: v > 1)
              (foldAttrs (acc: v: acc + v) 0
                (builtins.map (v: { ${v.target} = 1; })
                  (flatten (mapAttrsToList (n: v: attrValues v) cfg))
                )
              )
            );
          dupsStr = concatStringsSep ", " dups;
        in {
          assertion = dups == [];
          message = ''
            Conflicting managed target files: ${dupsStr}
            This may happen, for example, if you have a configuration similar to
              environment.overlay.users.<name> = {
                conflict1 = { source = ./foo.nix; target = "baz"; };
                conflict2 = { source = ./bar.nix; target = "baz"; };
              }
          '';
        })
      ];

      fileSystems = (mapper (user: files: {
        name = "/run/overlay_files/${user}";
        value = {
          device = "overlay";
          fsType = "overlay";
          options = [
            "rw" "nosuid"
            "lowerdir=${storePath}/${user}"
            "upperdir=${upper_dir}/${user}"
            "workdir=${work_dir}/${user}"
          ];
          noCheck = true;
          depends = [
            "/nix" "/run"
            "${upper_dir}/${user}"
            "${work_dir}/${user}"
          ];
        };
      }));

      systemd.services = (folder (sum: user: files:
        let
          next = "overlayfile-${user}-pre-mount.service";
          overlayPkg = pkgs.runCommand "overlay-packfile-${user}"
            { nativeBuildInputs = with pkgs; [ coreutils ]; }
            (
              (builtins.readFile ./scripts/insert_file.sh) +
              (traceVal (concatStrings (
                mapAttrsToList (n: v: ''
                  insertFile ${escapeShellArgs [
                    (sourceStorePath v)           # Source
                    v.target                      # relTarget
                  ]}
                '') files
              )))
            );
        in {
          "overlayfile-${user}-copy-check" =
            let
              _store = "${storePath}/${user}";
              storeHash = baseNameOf overlayPkg;
              storeLock = "${_store}-lock-${storeHash}";

              copyScript = pkgs.writeShellScriptBin "overlay-${user}-copy" ''
                out="${_store}"
                sou="$(realpath -m "${overlayPkg}")"
                owner="${toString user}"
                group="${toString config.users.users.${user}.group}"

                mkdir -p "$out"
                rm -vf "$out-lock-"*
                rm -vrf "$out"/*
                rm -vrf "$out"/.*

                cp -vrfHL "$sou"/. "$out"
                echo "$sou" > "${storeLock}"
                chown -cR $owner:$group "$out"
                chmod -cR 1700 "$out"
              '';

              rmFlagScript = pkgs.writeShellScriptBin "overlay-${user}-rm-flag" ''
                rm -r "${storeLock}"
              '';
            in {
              path = with pkgs; [ coreutils ];
              unitConfig = {
                Description = "Check availablity of overlay files for ${user} and copy them";
                DefaultDependencies = "no";
                Before = next;
                # BindsTo = "overlayfile-${user}-pre-mount.service";
                ConditionPathExists = "!${storeLock}";
              };

              serviceConfig = {
                Type = "oneshot";
                RemainAfterExit = "yes";
                ExecStart = "${getExe copyScript}";
                ExecStop = "${getExe rmFlagScript}";
              };

              wantedBy = [ next "local-fs.target" ];
            };

          "overlayfile-${user}-pre-mount" =
            let
              prev = "overlayfile-${user}-copy-check.service";
              next = "run-overlay_files-${strings.escapeC ["-"] user}.mount";
              preMountScript = pkgs.writeShellScriptBin "overlay-${user}-pre-mount" ''
                mkdir -p ${upper_dir}/${user}
                mkdir -p ${work_dir}/${user}
                chown ${user}:users ${upper_dir}/${user}
              '';

              reMountScript = pkgs.writeShellScriptBin "overlay-${user}-pre-mount" ''
                rm -rf ${upper_dir}/${user}/*
                rm -rf ${upper_dir}/${user}/.*
                rm -rf ${work_dir}/${user}/*
                rm -rf ${work_dir}/${user}/.*
              '';
            in {
              path = with pkgs; [ coreutils ];
              unitConfig = {
                Description = "Create Upperdir and Workdir for overlay files of ${user}";
                DefaultDependencies = "no";
                Before = next;
                ConsistsOf= next;
                Requires = prev;
                After = prev;
                PartOf = prev;
              };
              
              serviceConfig = {
                Type = "oneshot";
                RemainAfterExit = "yes";
                ExecStart = "${getExe preMountScript}";
                ExecStop = "${getExe reMountScript}";
              };

              requiredBy = [ next ];
              wantedBy = [ next "local-fs.target" ];
            };

          "overlayfile-${user}-link-file" =
            let
              prev = "run-overlay_files-${strings.escapeC ["-"] user}.mount";
              linkScript = pkgs.writeShellScriptBin "overlay-${user}-link" ''
                cp -vsrfp "/run/overlay_files/${user}"/. "${config.users.users.${user}.home}"
              '';
            in {
              path = with pkgs; [ coreutils ];
              unitConfig = {
                Description = "Link overlay files for ${user}";
                DefaultDependencies = "no";
                After = prev;
                PartOf = prev;
                Requires = prev;
              };

              serviceConfig = {
                Type = "oneshot";
                RemainAfterExit = "yes";
                ExecStart = "${getExe linkScript}";
              };

              wantedBy = [ "local-fs.target" ];
            };
        } // sum
      ));
    });
}