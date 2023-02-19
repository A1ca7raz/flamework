{ self }:
{
  targetHost = "192.168.10.3";
  targetPort = 22;

  activeModules = with self.nixosModules ; [ 
    v2raya
  ];

  components = {
    optionalComponents = [
      "binary-cache-cn"
      "desktop"
      #"secureboot"
    ];

    blacklist = [];
  };

  homeModuleHelper.nomad = [
    "laptop"
  ];

  extraConfiguration = { ... }: {
    networking.hostName = "oxygenlaptop";
  };
}