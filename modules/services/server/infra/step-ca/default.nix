{ pkgs, config, tools, lib, ... }:
let
  constant = config.lib.services.step-ca;
in {
  utils.secrets.acme-x1.enable = true;
  sops.secrets.acme-x1 = {
    mode = "0600";
    owner = "step";
    group = "step";
    path = "/var/lib/step-ca/templates/acme-x1.tpl";
  };

  users.users.step = {
    isSystemUser = true;
    description = "Step-CA deamon user";
    home = "/var/lib/step-ca";
    group = "step";
  };
  users.groups.step = {};

  imports = [ ./service.nix ];

  environment.systemPackages = [ pkgs.step-cli ];

  networking.hosts = lib.foldl (acc: ip:
    acc // { ${ip} = constant.domains; }
  ) {} (tools.removeCIDRSuffixes constant.ipAddrs);
}