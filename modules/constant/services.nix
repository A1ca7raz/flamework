{ ... }:
{
  lib.services = {
    vnet.ipAddrs = [
      "198.18.10.254/24"
    ];

    postgresql = {
      domains = [ "psql.insyder" ];
      ipAddrs = [ "198.18.10.1/24" ];
    };

    redis = {
      domains = [ "redis.insyder" ];
      ipAddrs = [ "198.18.10.2/24" ];
    };

    minio = {
      domains = [ "s3.insyder" ];
      ipAddrs = [ "198.18.10.3/24" ];
    };

    step-ca = {
      domains = [ "pki.insyder" ];
      ipAddrs = [ "198.18.10.4/24" ];
    };
  };
}