{
  homeModule = { pkgs, ... }: {
    home.packages = [ pkgs.logseq ];
  };

  nixosModule = { user, util, ... }:
  with util; mkPersistDirsModule user [
    (c "Logseq") ".logseq"
  ];
}