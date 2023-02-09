{ pkgs, ... }:
{
  home.packages = with pkgs; [
    htop
    curl
    vim
    wget
  ];

  programs.vim.defaultEditor = true;
}