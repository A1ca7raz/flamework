{ ... }:
{
  services.xserver.displayManager.defaultSession = "plasmawayland";
  services.xserver.displayManager.sddm.settings.General = {
    DisplayServer = "wayland";
    GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell";
  };

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";   # Firefox Wayland
  };
}