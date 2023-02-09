{ self }:
{
  targetHost = "192.168.20.231";
  targetPort = 33322;

  activeModules = with self.nixosModules ; [ 
    nginx
  ];

  components = {
    optionalComponents = [
      "legacy-boot"
      "binary-cache-speedup"
    ];

    blacklist = [];
  };

  extraConfiguration = { utils, ... }: {
    networking.hostName = "test";

    utils.homeModules.root = [ "test" ];
  };
}

