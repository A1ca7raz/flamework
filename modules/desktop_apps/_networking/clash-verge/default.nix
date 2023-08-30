{
  nixosModule = { user, util, lib, pkgs, ... }:
    with util; (mkPersistDirsModule user [
      (c "clash-verge")
    ]) // {
      security.wrappers.clash-verge = {
        owner = "root";
        group = "root";
        capabilities = "cap_net_bind_service,cap_net_admin=+ep";
        source = "${lib.getExe pkgs.clash-verge}";
      };
    };

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.clash-verge ];
  };
}