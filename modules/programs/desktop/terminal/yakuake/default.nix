{
  nixosModule = { lib, user, ... }:
    with lib; mkOverlayModule user {
      yakuakerc = {
        source = ./yakuakerc;
        target = c "yakuakerc";
      };

      yakuake_notifyrc = {
        source = ./yakuake.notifyrc;
        target = c "yakuake.notifyrc";
      };
    };

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.kdePackages.yakuake ];
  };
}