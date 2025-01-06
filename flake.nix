{
  description = "Flamework 4";

  outputs = { ... }: {
    flakeModules = {
      modules = import ./flake-modules/modules;
      packages = import ./flake-modules/packages;
      profiles = import ./flake-modules/profiles;
    };

    lib = import ./lib;
  };
}
