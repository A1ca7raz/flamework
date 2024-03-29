{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curlFull
    dig
    expect
    file
    iperf
    lsof
    neofetch
    nmap
    openssl
    tcpdump
    usbutils
    vim
    wget
    whois
    wireguard-tools
  ];

  programs = {
    bash.vteIntegration = true;
    mosh.enable = true;
    mtr.enable = true;
    traceroute.enable = true;

    fuse = {
      mountMax = 32767;
      userAllowOther = true;
    };
  };

  programs.command-not-found.enable = false;
}