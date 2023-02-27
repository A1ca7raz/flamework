{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    jb-clion-fixed
    jb-datagrip-fixed
    jb-idea-fixed
    jb-pycharm-fixed
  ];
}