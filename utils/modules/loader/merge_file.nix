{ config, util, lib, self, path, ... }:
with lib; let
  cfg = config.utils.mkMergedFile;

  mergedString = mkOptionType rec {
    name = "mergedString";
    check = isString;
    merge = loc: defs:
      ;
    emptyValue = { value = ""; };
    getSubOptions = prefix: elemType.getSubOptions (prefix ++ ["*"]);
    getSubModules = elemType.getSubModules;
    substSubModules = m: listOf (elemType.substSubModules m);
    functor = (defaultFunctor name) // { wrapped = elemType; };
    nestedTypes.elemType = elemType;
  };

  fileType = types.submodule (
    { name, config, ... }: {
      options = {
        text = mkOption {
          type = ;
          default = null;
          description = ''
            Text of the file. If this option is null then
            <xref linkend="opt-home.file._name_.source"/>
            must be set.
          '';
        };

        path = mkOption {
          type = types.path;
        };
      };
    }
  );
in {
  options.utils.mkMergedFile = {
    type = types.attrsOf (str);
    default = {};
    description = "";
  };

  config = mkIf (cfg != {}) {

  };
}