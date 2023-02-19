{
  source,
  stdenv,
  lib,
  fetchFromGitHub,
  cmake,
  dbus,
  libsForQt5,
  xorg
  # qtbase,
  # qttools
}:
stdenv.mkDerivation rec {
  inherit (source) pname version src;

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = with libsForQt5; [
    dbus
    xorg.libX11
    xorg.libSM
    qt5.qtbase
    qt5.qttools
    qt5.wrapQtAppsHook
  ];

  meta = with lib; {
    description = "Tray icon for Spotify Linux client application";
    homepage = "https://github.com/macdems/yet-another-spotify-tray";
    license = licenses.mit;
  };
}
