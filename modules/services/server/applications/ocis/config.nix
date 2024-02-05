{ config, lib, tools, pkgs, ... }:
with lib; let
  cfg = config.utils.ocis;
  enabled = {
    sopsFile = ./secrets.yml;
  };

  inherit (generators) toKeyValue;

  toYAML = x: pkgs.runCommand "toYaml" { nativeBuildInputs = [ pkgs.json2yaml ]; } ''
    json2yaml > $out << EOF
    ${builtins.toJSON x}
    EOF
  '';
in {
  imports = tools.importsFiles ./config;
  options.utils.ocis = lib.mkOption {
    default = {};
    type = with types; attrsOf attrs;
  };

  config = {
    # Secrets
    sops.secrets = {
      "ocis/minio_access_key_id" = enabled;
      "ocis/minio_secret_access_key" = enabled;
      "ocis/oauth_id" = enabled;
      "ocis/jwt_secret" = enabled;
      "ocis/machine_auth_api_key" = enabled;
      "ocis/system_user_api_key" = enabled;
      "ocis/transfer_secret" = enabled;
      "ocis/service_account_secret" = enabled;
      "ocis/admin_password" = enabled;
      "ocis/idm_password" = enabled;
      "ocis/reva_password" = enabled;
      "ocis/idp_password" = enabled;
      "ocis/thumbnails_transfer_secret" = enabled;
    };

    sops.templates = {
      # Environment File
      ocis_env.content = toKeyValue {} config.lib.ocis_env;
    } // (mapAttrs' (n: v: nameValuePair "ocis_${n}" {
        content = builtins.readFile (toYAML v).outPath;
        owner = "ocis";
        group = "ocis";
        mode = "0600";
        path = "/var/lib/ocis/conf/${n}.yaml";
    }) cfg);
  };
}