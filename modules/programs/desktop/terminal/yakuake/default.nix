{
  nixosModule = { tools, user, ... }:
    with tools; mkOverlayModule user {
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