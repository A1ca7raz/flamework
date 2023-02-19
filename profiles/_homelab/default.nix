{ self }:
{
  targetHost = "192.168.20.231";
  targetPort = 22;

  activeModules = with self.nixosModules ; [ 
    nginx
  ];

  components = {
    optionalComponents = [
      "legacy-boot"
      "binary-cache-cn"
    ];

    blacklist = [];
  };

  extraConfiguration = { utils, ... }: {
    networking.hostName = "test";
    systemd.services.nginx.enable = false;
    # utils.homeModules.root = [ "test" ];
  };
}

