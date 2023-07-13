{ pkgs, ... }:
{
  # Htop
  programs.htop = {
    enable = true;
    settings = {
      highlight_base_name = 1;
      highlight_changes = 1;
      show_merged_command = 1;
      show_cpu_frequency = 1;
      show_cpu_temperature = 1;
      color_scheme = 6;
      delay = 10;
      column_meters_0 = "LeftCPUs2 Memory Swap DateTime Uptime";
      column_meter_modes_0 = "1 1 1 2 2";
      column_meters_1 = "RightCPUs2 CPU Tasks LoadAverage";
      column_meter_modes_1 = "1 2 2 2";
      tree_view = 1;
    };
  };

  # Git (Global)
  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = "vim";
      };
    };
  };

  # Tmux
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    escapeTime = 10;
  };

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
}