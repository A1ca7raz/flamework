{ ... }:
{
  services.xserver.displayManager.defaultSession = "plasmawayland";
  services.xserver.displayManager.sddm.settings = {
    General = {
      DisplayServer = "wayland";
      GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell";
    };

    Wayland.CompositorCommand = "kwin_wayland_wrapper --no-kactivities --no-lockscreen --locale1";
  };
}