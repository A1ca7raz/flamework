{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.utils.netns;
in {
  options.utils.netns = {
    enable = mkEnableOption "enable netns management";
  };

  config = mkIf cfg.enable {
    systemd.services."netns@" = {
      description = "Named network namespace %I";
      documentation = [
        "https://github.com/systemd/systemd/issues/2741#issuecomment-336736214"
      ];
      requires = [ "network-online.target" ];
      after = [ "network-online.target" ];

      unitConfig = {
        StopWhenUnneeded = true;
      };

      serviceConfig =
        let
          ip = "${pkgs.iproute2}/bin/ip";
        in {
          Type = "oneshot";
          RemainAfterExit = true;

          ExecStart = [
            "${ip} netns add %i"
            "${ip} -n %i link set lo up"
          ];

          ExecStop = "${ip} netns del %i";
        };
    };
  };
}