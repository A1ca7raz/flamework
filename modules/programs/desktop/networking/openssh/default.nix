{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [ ".ssh" ];

  homeModule = { config, var, ... }: {
    utils.secrets.sshconfig.path = ./sshconfig.enc.json;

    programs.ssh = {
      enable = true;
      includes = [ config.sops.secrets.sshconfig.path ];
      
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
