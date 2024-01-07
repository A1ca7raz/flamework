{ ... }:
{
  # 使用 systemd-networkd 管理网络
  systemd.network.enable = true;
  services.resolved.enable = false;

  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];
}