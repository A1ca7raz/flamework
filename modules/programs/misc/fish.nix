{ ... }:
{
  programs.fish = {
    enable = true;
    useBabelfish = true;

    interactiveShellInit = ''
      set -U fish_greeting
    '';
  };
}