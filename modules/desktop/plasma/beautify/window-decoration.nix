{
  nixosModule = { tools, user, ... }:
    with tools; mkOverlayModule user {
      sierrabreezeenhancedrc = {
        target = c "sierrabreezeenhancedrc";
        source = ./sierrabreezeenhancedrc;
      };
    };

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.sierra-breeze-enhanced-wayland ];
  };
}