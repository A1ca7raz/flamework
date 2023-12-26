{
  homeModule = { tools, ... }: {
    imports = tools.importsFiles ./.;
  };

  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [
      ".ssh"
      (c "autostart")
    ];
}