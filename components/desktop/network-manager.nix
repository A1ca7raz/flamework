{ pkgs, ... }:
{
  environment.persistence."/nix/persist".directories = [
    "/etc/NetworkManager/system-connections"
  ];

  environment.systemPackages = with pkgs; [
    iw
    iwd
    # networkmanager-openvpn
  ];

  users.users.nomad.extraGroups = [ "networkmanager" ];
  users.extraGroups.networkmanager.members = ["root"];

  networking.networkmanager = {
    enable = true;
    # enableFccUnlock = true; # Deprecated
    # dns = "dnsmasq";

    # NOTE: Use wpa_supplicant for WiFi-Direct support
    # wifi.backend = "iwd";
    # firewallBackend = "none"; # Deprecated
    plugins = with pkgs; [ networkmanager-openvpn ];
  };
}