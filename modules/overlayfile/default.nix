{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.environment.overlay.users;

  fileType = (import ./file-type.nix { inherit lib pkgs; });
  storeFileName = (import ./lib.nix { inherit lib; }).storeFileName;
  sourceStorePath = file:
  let
    sourcePath = toString file.source;
    sourceName = storeFileName (baseNameOf sourcePath);
  in
    if builtins.hasContext sourcePath
    then file.source
    else builtins.path { path = file.source; name = sourceName; };
in {
  options.environment.overlay.users = mkOption {
    type = types.attrsOf fileType;
    default = {};
    description = "Attribute set of files to link into the user home.";
  };
  j = mkIf (cfg != {}) (mkMerge (
    (flip mapAttrsToList cfg (user: files:
      let
        preMount = "overlay_files-${strings.escapeC ["-"] user}-premount";
        preMountService = preMount + ".service";

        overlayPkg = pkgs.runCommandLocal "overlay-files-${user}"
          { nativeBuildInputs = [ pkgs.xorg.lndir ]; }
          (
            (builtins.readFile ./scripts/insert_file.sh) +
            concatStrings (
              mapAttrsToList (n: v: ''
                insertFile ${
                  escapeShellArgs [
                    (sourceStorePath v)           # Source
                    v.target                      # relTarget
                    (                             # executable
                      if v.executable == null
                      then "inherit"
                      else toString v.executable
                    )
                    (toString v.recursive)        # recursive
                  ]
                }
              '') files
            )
          );
      in rec {
        filesystems."/run/overlay_files/${user}" = {
          device = "overlay";
          fsType = "overlay";
          options = [
            "rw"
            "lowerdir=${overlayPkg}"
            "upperdir=/tmp/overlay_files_upper/${user}"
            "workdir=/tmp/overlay_files_work/${user}"
            "x-gvfs-hide"
            "x-systemd.after=${preMountService}"
            "x-systemd.requires=${preMountService}"
          ];
          noCheck = true;
          depends = [ "/nix" "/tmp" "/run" ];
        };

        systemd.services."${preMount}" = {
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = "yes";
            ExecStart = "mkdir -p /tmp/overlay_files_{upper,work}/${user}";
            ExecStop = "rm -rf /tmp/overlay_files_{upper,work}/${user}";
          };
        };

        system.userActivationScripts.checkLinkTargets = {
          text =
          let
            # Paths that should be forcibly overwritten by Home Manager.
            # Caveat emptor!
            forcedPaths = concatMapStringsSep " " (p: ''"$HOME"/${escapeShellArg p}'')
              (mapAttrsToList (n: v: v.target) (filterAttrs (n: v: v.force) files));

            check = pkgs.writeText "check" ''
              source ${./scripts/common.sh}

              # A symbolic link whose target path matches this pattern will be
              # considered part of a Overlay generation.
              overlayFilePattern="$(readlink -e ${escapeShellArg builtins.storeDir})/*-overlay-files-${user}/*"

              forcedPaths=(${forcedPaths})

              newGenFiles="$1"
              shift
              for sourcePath in "$@"; do
                relativePath="''${sourcePath#$newGenFiles/}"
                targetPath="$HOME/$relativePath"

                forced=""
                for forcedPath in "''${forcedPaths[@]}"; do
                  if [[ $targetPath == $forcedPath* ]]; then
                    forced="yeah"
                    break
                  fi
                done

                if [[ -n $forced ]]; then
                  $VERBOSE_ECHO "Skipping collision check for $targetPath"
                elif [[ -e "$targetPath" && ! "$(readlink "$targetPath")" == $overlayFilePattern ]]; then
                  # The target file already exists and it isn't a symlink owned by Overlay Files.
                  if cmp -s "$sourcePath" "$targetPath"; then
                    # First compare the files' content. If they're equal, we're fine.
                    warnEcho "Existing file '$targetPath' is in the way of '$sourcePath', will be skipped since they are the same"
                  else
                    # Fail if nothing else works
                    errorEcho "Existing file '$targetPath' is in the way of '$sourcePath'"
                    collision=1
                  fi
                fi
              done

              if [[ -v collision ]]; then
                errorEcho "Please move the above files and try again."
                exit 1
              fi
            '';
          in ''
            function checkNewGenCollision() {
              local newGenFiles
              newGenFiles="$(readlink -e "${overlayPkg}")"
              find "$newGenFiles" \( -type f -or -type l \) -exec bash ${check} "$newGenFiles" {} +
            }

            checkNewGenCollision || exit 1
          '';
        };

        system.userActivationScripts.linkGeneration = {
          deps = ["checkLinkTargets"];
          text =
          let
            link = pkgs.writeShellScript "link" ''
              newGenFiles="$1"
              shift
              for sourcePath in "$@"; do
                relativePath="''${sourcePath#$newGenFiles/}"
                targetPath="$HOME/$relativePath"

                # Place that symlink, --force
                # This can still fail if the target is a directory, in which case we bail out.
                $DRY_RUN_CMD mkdir -p $VERBOSE_ARG "$(dirname "$targetPath")"
                $DRY_RUN_CMD ln -Tsf $VERBOSE_ARG "$sourcePath" "$targetPath" || exit 1
              done
            '';
          in ''
            function linkNewGen() {
              _i "Creating home file links in %s" "$HOME"

              local newGenFiles
              newGenFiles="$(readlink -e "${overlayPkg}")"
              find "$newGenFiles" \( -type f -or -type l \) -exec bash ${link} "$newGenFiles" {} +
            }

            linkNewGen
          '';
        };
      }
    )) ++ [{
      assertions = [(
        let
          dups = attrNames
            (filterAttrs (n: v: v > 1)
              (foldAttrs (acc: v: acc + v) 0
                (builtins.map (v: { ${v.target} = 1; })
                  (flatten (mappAttrsToList (n: v: attrValues v) cfg))
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
        }
      )];
    }]
  ));
}