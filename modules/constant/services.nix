{ ... }:
{
  config.lib.services = {
    step-ca = {
      domains = [ "pki.insyder" ];

      ipAddrs = [
        "198.18.10.10/24"
      ];
    };

    postgresql = {
      domains = [ "psql.insyder" ];
      ipAddrs = [
        "198.18.10.1/24"
      ];
    };
  };
}