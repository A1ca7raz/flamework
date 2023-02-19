{
  source,
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  extra-cmake-modules,
  libsForQt5,
  # kdeclarative,
  # kdecoration,
  # kwindowsystem,
  libdbusmenu-gtk2,
  libdbusmenu-gtk3,
  xorg
  # plasma-framework,
  # qtbase,
  # qtdeclarative
}:
stdenv.mkDerivation rec {
  inherit (source) pname version src;

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
  ];

  buildInputs = with libsForQt5; [
    kconfigwidgets
    kdeclarative
    kdecoration
    kwindowsystem
    libdbusmenu-gtk2
    libdbusmenu-gtk3
    xorg.libxcb
    xorg.libSM
    plasma-framework
    plasma-workspace
    qt5.qtbase
    qt5.qtdeclarative
    qt5.qtx11extras
    qt5.wrapQtAppsHook
  ];

  meta = with lib; {
    description = "Plasma 5 applet in order to show the window appmenu";
    homepage = "https://github.com/psifidotos/applet-window-appmenu";
    license = licenses.gpl2Plus;
  };
}
