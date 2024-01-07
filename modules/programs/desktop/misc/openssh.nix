{
  nixosModule = { user, tools, ... }:
    with tools; mkPersistDirsModule user [ ".ssh" ];

  homeModule = { ... }: {
    programs.ssh = {
      enable = true;
      includes = [ "/run/user/1000/secrets/sshconfig" ];
    };
  };
}
