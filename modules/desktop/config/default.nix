{
  homeModule = { util, ... }: {
    imports = util.importsFiles ./.;
  };

  nixosModule = { user, util, ... }:
    with util; mkPersistDirsModule user [
      ".ssh"
      (c "autostart")
    ];
}

