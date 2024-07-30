self:
let
  path = builtins.toPath ./..;
  inputs = self.inputs;
  lib = self.inputs.nixpkgs.lib.extend(scopedImport { inherit (self.inputs.nixpkgs) lib; } ./lib);

  moduleRegistry = import ./registry.nix;
  moduleScanner = new: sum:
    if new.type == "dir"
    then { ${new.name} = lib.mkModuleTreeFromDirs /${path}/${new.path}; } // sum
    else if new.type == "file"
    then { ${new.name} = lib.mkModuleTreeFromFiles /${path}/${new.path}; } // sum
    else sum;
in {

  # Load Flake Utilities
  profiles = import ./profiles { inherit self path inputs lib; };

  # Load User-defined Modules
  modules = (lib.fold moduleScanner {} moduleRegistry) // {
    # Load Module Utilities
    utils = { lib, ... }: {
      imports = lib.foldGetDir
        ./modules
        []
        (x: y: [ ./modules/${x} ] ++ y);
    };
  };

  packages = pkgs: lib.foldGetDir /${path}/pkgs {}
    (pkg: acc:
      { "${pkg}" = pkgs.callPackage (import /${path}/pkgs/${pkg}) { inherit lib; } ; } // acc
    );

  overlays.pkgs = final: prev: {
    flameworkPackages = lib.mapPackages (lib.callPackage final lib) "function" /${path}/pkgs;
  };
}
