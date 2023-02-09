{ util, lib, self, path, ... }:
let
  secret_path = /${path}/config/secrets;
in {
  imports = [
    self.nixosModules.sops
  ];

  sops.secrets = util.foldGetFile secret_path {}
    (x: y:
      if util.hasSuffix ".yaml" x
      then rec {
        "${util.removeSuffix ".yaml" x}" = {
          sopsFile = /${secret_path}/${x};
          format = "binary";
        };
      } // y
      else y
    );
}