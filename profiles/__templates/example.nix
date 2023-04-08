{ ... }:
{
  # targetPort = 8022;
  # targetUser = "";

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