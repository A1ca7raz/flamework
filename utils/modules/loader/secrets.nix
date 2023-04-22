{ util, lib, self, path, ... }:
let
  secret_path = /${path}/config/secrets;
in {
  imports = [ self.nixosModules.sops ];
} // lib.optionalAttrs (builtins.pathExists secret_path) {
  sops.secrets = util.foldGetFile secret_path {}
    (x: y:
      if util.hasSuffix ".json" x
      then rec {
        "${util.removeSuffix ".json" x}" = {
          sopsFile = /${secret_path}/${x};
          format = "binary";
        };
      } // y
      else y
    );
}