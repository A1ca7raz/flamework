{ pkgs, lib, ... }:
let
  rpJbJdk = pkg: lib.forEach pkg (x: x.override {
    jdk = pkgs.jetbrains.jdk;
    vmopts = "-Dawt.useSystemAAFontSettings=lcd";
  });
in
{
  home.packages = rpJbJdk (with pkgs; with jetbrains; [
    clion
    pycharm-professional
    idea-ultimate
    datagrip
  ]);
}