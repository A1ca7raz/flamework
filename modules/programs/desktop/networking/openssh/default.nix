{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [ ".ssh" ];

  homeModule = { config, var, ... }: {
    utils.secrets.sshconfig.enable = true;

    programs.ssh = {
      enable = true;
      # fix %r
      includes = [ "/run/user/1000/secrets/sshconfig" ];
      
      matchBlocks = {
        gh = {
          hostname = "github.com";
          user = "git";
        };
        gl = {
          hostname = "gitlab.com";
          user = "git";
        };
        "*.node" = {
          port = var.port.ssh;
        };
      };
    };
  };
}
