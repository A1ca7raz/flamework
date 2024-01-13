{ ... }:
let
  listenAddr = "127.10.0.2:80";
in {
  imports = [ ./service.nix ];

  utils.secrets.acme-x1.enable = true;
  sops.secrets.acme-x1 = {
    mode = "0600";
    owner = "step";
    group = "step";
    path = "/var/lib/step/templates/acme-x1.tpl";
  };

  # Caddy
  services.caddy.virtualHosts.step-ca = {
    hostName = "";
    listenAddresses = [ "0.0.0.0" "::0" ];
    serverAliases = [];

    extraConfig = ''
      reverse_proxy http://${listenAddr}
    '';
  };
}