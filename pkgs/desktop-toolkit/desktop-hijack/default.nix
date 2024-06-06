{
  lib,
  kdePackages,
  makeWrapper,
  binName ? "hijack",
  stdenv
}:
stdenv.mkDerivation {
  pname = "desktop-hijack";
  version = "1.0.0";

  src = ./src;

  dontWrapQtApps = true;
  buildInputs = [ kdePackages.qttools ];
  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/{share,bin}

    cp -r * $out
    makeWrapper $out/desktop-hijack $out/bin/desktop-hijack \
      --set-default DESKTOP_HIJACK_SCRIPT $out/share/desktop-hijack/lock.js

    ${lib.optionals (binName != "" && binName != null) "cp $out/bin/desktop-hijack $out/bin/${binName}"}
  '';
}
