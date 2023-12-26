{ tools, lib, path, ... }:
with lib; let
  secret_path = /${path}/config/secrets_home;
in {
  sops = {
    age = {
      keyFile = mkDefault "/var/lib/age.home.key";
      sshKeyPaths = mkDefault [];
      generateKey = mkDefault false;
    };
    gnupg.sshKeyPaths = mkDefault [];
    secrets = optionalAttrs (builtins.pathExists secret_path)
      (tools.foldGetFile secret_path {}
        (x: y:
          if hasSuffix ".json" x
          then 
            {
              "${removeSuffix ".json" x}" = {
                sopsFile = /${secret_path}/${x};
                format = "binary";
              };
            } // y
          else y
        )
      );
  };
}