{ ... }:
{
  xdg.configFile = {
    kiorc = {
      target = "kiorc";
      text = ''
        [Confirmations]
        ConfirmDelete=false
        ConfirmEmptyTrash=false
        ConfirmTrash=false

        [Executable scripts]
        behaviourOnLaunch=open
      '';
    };
  };
}