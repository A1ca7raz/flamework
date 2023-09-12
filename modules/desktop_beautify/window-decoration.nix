{
  nixosModule = { util, user, ... }:
  with util; mkOverlayModule user {
    sierrabreezeenhancedrc = {
      target = c "sierrabreezeenhancedrc";
      source = ./sierrabreezeenhancedrc;
    };
  };

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.sierra-breeze-enhanced-wayland ];
  };
}