{ ... }:
{
  nix.settings.substituters = [
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    "https://mirrors.bfsu.edu.cn/nix-channels/store"
    "https://mirrors.ustc.edu.cn/nix-channels/store"

    "https://cache.nixos.org/"
  ];
}