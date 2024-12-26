{ pkgs, ... }:
# https://xtls.github.io/document/level-2/tproxy.html#netfilter-%E9%85%8D%E7%BD%AE
let
  fwmark = 10;
  routingMark = 20;

  table4 = 110;
  table6 = 111;

  tproxyPort = 8848;
in {
  systemd.services.mihomo-tproxy = {
    description = "Set up tproxy for Mihomo";
    after = [ "mihomo.service" ];
    requires = [ "mihomo.service" ];
    path = with pkgs; [
      iproute2
      nftables
    ];

    serviceConfig =
    let
      rules = pkgs.writeText "mihomo-tproxy-nftables" ''
        flush ruleset

        define RESERVED_IP = {
          # 10.0.0.0/8,
          100.64.0.0/10,
          127.0.0.0/8,
          169.254.0.0/16,
          # 172.16.0.0/12,
          192.0.0.0/24,
          224.0.0.0/4,
          # 240.0.0.0/4,
          255.255.255.255/32
        }

        define RESERVED_IP_6 = {
          ::1,
          fe80::/10
        }

        table inet tproxy {
          chain prerouting {
            type filter hook prerouting priority mangle; policy accept;

            ip daddr $RESERVED_IP return

            ip daddr 192.168.0.0/16 tcp dport != 53 return
            ip daddr 192.168.0.0/16 udp dport != 53 return

            ip6 daddr { ::1, fe80::/10 } return
            meta l4proto tcp ip6 daddr fd00::/8 return
            ip6 daddr fd00::/8 udp dport != 53 return

            meta mark ${toString routingMark} return

            meta l4proto { tcp, udp } meta mark set ${toString fwmark} tproxy ip to 127.0.0.1:${toString tproxyPort}
            meta l4proto { tcp, udp } meta mark set ${toString fwmark} tproxy ip6 to [::1]:${toString tproxyPort}
          }

          chain output {
            type route hook output priority mangle; policy accept;

            ip daddr $RESERVED_IP return

            ip daddr 192.168.0.0/16 tcp dport != 53 return
            ip daddr 192.168.0.0/16 udp dport != 53 return

            meta mark ${toString routingMark} return

            meta l4proto { tcp, udp } meta mark set ${toString fwmark} accept
          }

          chain divert {
            type filter hook prerouting priority mangle; policy accept;
            meta l4proto tcp socket transparent 1 meta mark set ${toString fwmark} accept
          }
        }
      '';

      cmd = "${pkgs.nftables}/bin/nft -f ${rules}";
    in {
      Type = "oneshot";
      RemainAfterExit = true;
      ProtectHome = true;
      StandardInput = "null";
      ProtectSystem = "full";

      ExecStart = cmd;
      ExecReload = cmd;
    };

    preStart = ''
      ip route add local default dev lo table ${toString table4}
      ip rule add fwmark ${toString fwmark} table ${toString table4}
      ip -6 rule add fwmark ${toString fwmark} table ${toString table6}
      ip -6 route add local dev lo table ${toString table6}
    '';

    preStop = ''
      nft flush ruleset
      ip route del local default dev lo table ${toString table4}
      ip rule del table ${toString table4}
      ip -6 rule del table ${toString table6}
      ip -6 route del local dev lo table ${toString table6}
    '';
  };
}
