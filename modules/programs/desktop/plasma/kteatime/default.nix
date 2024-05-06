{
  nixosModule = { user, lib, ... }:
    with lib; mkOverlayModule user {
      kteatime_notifyrc = {
        source = ./kteatime.notifyrc;
        target = c "kteatime.notifyrc";
      };

      kteatimerc = {
        source = ./kteatimerc;
        target = c "kteatimerc";
      };
    };

    homeModule = { pkgs, ... }: {
      home.packages = [ pkgs.kdePackages.kteatime ];
    };
}