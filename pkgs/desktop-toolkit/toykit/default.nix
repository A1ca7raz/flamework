{
  lib,
  stdenv
}:
stdenv.mkDerivation {
  pname = "toykit";
  version = "1.0.0";

  src = ./src;

  installPhase = ''
    mkdir -p $out/bin

    cp -r * $out/bin
  '';
}
