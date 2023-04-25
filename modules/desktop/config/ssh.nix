{ config, ... }:
{
  programs.ssh = {
    enable = true;
    includes = [ "/run/user/1000/secrets/sshconfig" ];
  };
}