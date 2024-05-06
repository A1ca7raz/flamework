{ user, lib, ... }:
with lib; {
  programs.fish = {
    enable = true;
    useBabelfish = true;

    interactiveShellInit = ''
      set -U fish_greeting
    '';
  };

  environment.persistence = mkPersistDirsTree user [
    (ls "fish")
  ];
}