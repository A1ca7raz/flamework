{
  nixosModule = { user, util, lib, ... }:
  with util; lib.mkMerge [
    (mkPersistDirsModule user [
      ".mozilla/thunderbird"
      ".thunderbird"
    ])
    (mkPersistFilesModule user [
      (c "birdtray-config.json")
    ])
  ];

  homeModule = { pkgs, ... }: {
    home.packages = with pkgs; [
      birdtray
      thunderbird
    ];
  };
}
