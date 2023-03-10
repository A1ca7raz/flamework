{ pkgs, ... }:
{
  environment.persistence."/nix/persist".directories = [
    "/etc/NetworkManager/system-connections"
  ];

  environment.systemPackages = with pkgs; [ iw iwd ];

  users.users.nomad.extraGroups = [ "networkmanager" ];

  networking.networkmanager = {
    enable = true;
    enableFccUnlock = true;
    # dns = "dnsmasq";
    wifi.backend = "iwd";
    firewallBackend = "none";
  };
}