{ pkgs, ... }:
{
  services.fail2ban = {
    enable = true;
    maxretry = 5;

    banaction = "nftables-multiport";
    banaction-allports = "nftables-allports";
    packageFirewall = pkgs.nftables-fullcone;

    daemonConfig = ''
      [DEFAULT]
      loglevel = NOTICE
      logtarget = SYSLOG
      socket    = /run/fail2ban/fail2ban.sock
      pidfile   = /run/fail2ban/fail2ban.pid
      dbfile    = /var/lib/fail2ban/fail2ban.sqlite3
    '';
    bantime-increment = {
      enable = true;
      overalljails = true;
    };
  };
}