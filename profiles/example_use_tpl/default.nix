{
  example,  # Name of the template to use
  components,
  modules,
  ...
}:
example {
  # targetHost = "192.168.2.1";
  # targetPort = 22;
  targetUser = "";
  # system = "x86_64-linux";

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