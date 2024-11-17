{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [ ".ssh" ];

  homeModule = { var, ... }: {
    programs.ssh = {
      enable = true;
      includes = [
        (builtins.fetchurl {
          url = "https://raw.githubusercontent.com/AOSC-Dev/Buildbots/main/ssh_config";
          sha256 = "sha256:15rn516vgdih0kqc08a33dqy6nivm5pgvmqi9mxjm2pnsxgffnal";
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
        "*.felixc.at" = {
          forwardAgent = true;
        };
      };
    };

    home.file.aosc-known-hosts = {
      source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/AOSC-Dev/Buildbots/main/ssh_known_hosts";
        sha256 = "sha256:123mmjhihs89kczfjsnwfc5bfv4m0lfh6qzs7ck20v544qb2l2cw";
      };
      target = ".ssh/known_hosts.d/aosc";
    };
  };
}
