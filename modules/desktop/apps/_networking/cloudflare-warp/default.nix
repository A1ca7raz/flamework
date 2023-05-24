{
  nixosModule = import ./service.nix;

  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.cloudflare-warp ];
    systemd.user.services.warp-taskbar.Install.WantedBy = [];
  };
}