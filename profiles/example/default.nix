{ self, ... }:
{
  # targetHost = "192.168.2.1";
  # targetPort = 22;
  targetUser = "root";
  # system = "x86_64-linux";

  modules = with self.nixosModules; [
    # ...
  ];

  users."username".modules = with self.nixosModules; [];

  extraConfig = { ... }: {
    # ...
  };
}