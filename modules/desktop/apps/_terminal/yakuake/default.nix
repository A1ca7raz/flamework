{
  nixosModule = { util, user, ... }:
  with util; mkOverlayModule user {
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
    home.packages = [ pkgs.yakuake ];
  };
}