{ pkgs, ... }:
{
  modules.clash = {
    enable = false;
    # package = pkgs.clash-meta;
    listen = "127.0.0.1:9090";
    configFile = "/home/nomad/.config/clash/clash.yaml";
    extraArgs = "-m";
    
    webUI = {
      enable = false;
      package = pkgs.clash-webui-yacd;
    };
  };

  environment.persistence."/nix/persist".users.nomad.directories = [
    ".config/clash"
  ];
}