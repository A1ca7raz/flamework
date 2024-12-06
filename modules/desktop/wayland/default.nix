{ user, lib, ... }:
{
  environment = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";   # Firefox Wayland
    };

    persistence = with lib; mkPersistDirsTree user [
      (ls "flatpak")  # XDG Desktop Portal
    ];
  };
}
