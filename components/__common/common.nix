{ ... }:
{
  time.timeZone = "Asia/Shanghai";

  users.mutableUsers = false;

  documentation.nixos.enable = false;
  programs.command-not-found.enable = false;

  system.stateVersion = "23.05";
}