{
  nixosModule = { pkgs, ... }: {
    services.udev.packages = [ pkgs.solaar ];
  };

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.solaar ];
  };
}
