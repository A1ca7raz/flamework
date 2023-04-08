{ templates, components, modules, ... }:
templates.example.use {
  # targetHost = "192.168.2.1";
  # targetPort = 22;
  targetUser = "";

  components.use = with components; [
    # xxx
  ];

  # modules.extraUsers = [ "" ];
  modules.use = with modules; [
    # xxx
  ];
  # modules.users."username" = with modules; [];

  extraConfiguration = { ... }: {
    # ...
  };
}