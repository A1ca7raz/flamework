{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.certificate;
in {
  options.certificate = {
    enable = mkEnableOption "Enable ACME Schedule";

    domains = mkOption {
      type = with types; nullOr (listOf str);
      default = null;
      description = "Domains to acme";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.domains != null;
        message = "Domains should not be left empty.";
      }
    ];

    security.acme.acceptTerms = true;
    
    security.acme.certs = fold (x: y: rec {
        "${x}" = {
          domain = "*.${x}";
          email = "abuse@pwd.moe";
          keyType = "ec384";
          dnsPropagationCheck = true;
          dnsProvider = "cloudflare";
          credentialsFile = "${config.sops.secrets.acme.path}";
          group = "nginx";
        };
      } // y) {} cfg.domains;
  };
}