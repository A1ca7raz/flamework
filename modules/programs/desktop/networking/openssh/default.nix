{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [ ".ssh" ];

  homeModule = { config, var, ... }: {
    utils.secrets.sshconfig.path = ./sshconfig.enc.json;

    programs.ssh = {
      enable = true;
      includes = [
        config.sops.secrets.sshconfig.path
        (builtins.fetchurl {
          url = "https://raw.githubusercontent.com/AOSC-Dev/Buildbots/main/ssh_config";
          sha256 = "sha256:1lh1hasggk739mzy48rymwa85d7l8db15gw6524ah9xy11m83f9i";
        })
      ];

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
        archcn = {
          hostname = "build.archlinuxcn.org";
          user = "a1ca7raz";
        };
      };
    };

    home.file.aosc-known-hosts = {
      source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/AOSC-Dev/Buildbots/main/ssh_known_hosts";
        sha256 = "sha256:0lha6r8kny27im1f1zn306d84vv4zc99k68vdy7hvwd9d274krpx";
      };
      target = ".ssh/known_hosts.d/aosc";
    };
  };
}
