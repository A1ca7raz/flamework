{ lib, tools, self, path, ... }:
with lib; let
  inherit (tools) foldGetFile;
  secret_path = /${path}/config/secrets;
in {
  imports = [ self.nixosModules.sops ];

  sops = {
    age = {
      keyFile = mkDefault "/var/lib/age.key";
      sshKeyPaths = mkDefault [];
      generateKey = mkDefault false;
    };
    gnupg.sshKeyPaths = mkDefault [];
    secrets = optionalAttrs (builtins.pathExists secret_path)
      (foldGetFile secret_path {}
        (x: y:
          if hasSuffix ".json" x
          then {
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