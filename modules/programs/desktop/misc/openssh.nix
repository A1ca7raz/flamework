{
  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [ ".ssh" ];

  homeModule = { config, ... }: {
    utils.secrets.sshconfig.enable = true;

    programs.ssh = {
      enable = true;
      includes = [ config.sops.secrets.sshconfig.path ];
    };
  };
}
