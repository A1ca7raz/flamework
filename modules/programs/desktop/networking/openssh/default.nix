{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [ ".ssh" ];

  homeModule = { const, ... }: {
    programs.ssh = {
      enable = true;
      includes = [
        (builtins.fetchurl {
          url = "https://raw.githubusercontent.com/AOSC-Dev/Buildbots/main/ssh_config";
          sha256 = "sha256:1zyc75cbzgd71wbmrlgha3nf5b3ifxpz2px7934hfnr7iaciqms3";
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
          port = const.port.ssh;
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
        sha256 = "sha256:0nv9h7zhzkc9k1z1jxikmdfn0yrhlk06wcp1xksh98r221i2mnh0";
      };
      target = ".ssh/known_hosts.d/aosc";
    };
  };
}
