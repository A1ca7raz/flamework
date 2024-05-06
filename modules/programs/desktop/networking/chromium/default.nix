{
  nixosModule = { user, lib, ... }:
    with lib; mkPersistDirsModule user [
      (c "chromium")
    ];

  homeModule = { pkgs, ... }: {
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium-drm;
    };
  };
}
