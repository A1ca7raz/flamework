{
  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      birdtray
      thunderbird
    ];
  };

  nixosModule = { user, util, ... }:
    with util; (mkPersistDirsModule user [
      ".mozilla/thunderbird"
      ".thunderbird"
    ]) // (mkPersistFilesModule user [
      (c "birdtray-config.json")
    ]);
}
