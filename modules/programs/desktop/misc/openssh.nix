{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [ ".ssh" ];

  homeModule = { config, ... }: {
    utils.secrets.sshconfig.enable = true;

    programs.ssh = {
      enable = true;
      # fix %r
      includes = [ "/run/user/1000/secrets/sshconfig" ];
    };
  };
}
