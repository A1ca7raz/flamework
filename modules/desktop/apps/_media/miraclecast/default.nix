{
  nixosModule = { pkgs, ... }: {
    services.dbus.packages = [ pkgs.miraclecast-my ];
  };

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.miraclecast-my pkgs.gnome-network-displays ];
  };
}