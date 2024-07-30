{
  lib,
  stdenv
}:
stdenv.mkDerivation {
  pname = "deploykit";
  version = "1.0.0";

  src = ./scripts;

  installPhase = ''
    mkdir -p $out/bin

    cp -r $src/* $out/bin/
    chmod +x $out/bin/*
  '';
}
