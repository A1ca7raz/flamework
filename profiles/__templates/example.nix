{ ... }:
{
  targetPort = 22;
  targetUser = "root";
  system = "x86_64-linux";

  components.groups.use = [ "" ];
  components.groups.useDefault = true;
  components.use = [ "" ];

  modules.groups.use = [ "" ];
  modules.groups.useDefault = true;
  modules.use = [ "" ];

  extraConfiguration = { ... }: {
    # ...
  };
}