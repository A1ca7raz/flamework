{ lib, pkgs }:
# https://github.com/nix-community/home-manager/blob/master/modules/lib/file-type.nix
let
  inherit (lib) hasPrefix literalExpression mkDefault mkIf mkOption removePrefix types;
  inherit (import ./lib.nix { inherit lib; }) storeFileName;
in
types.attrsOf (types.submodule (
  { name, config, ... }: {
    options = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Whether this file should be generated. This option allows specific
          files to be disabled.
        '';
      };

      target = mkOption {
        type = types.str;
        defaultText = literalExpression "<name>";
        description = ''
          Path to target file.
        '';
      };

      text = mkOption {
        default = null;
        type = types.nullOr types.lines;
        description = ''
          Text of the file. If this option is null then
          <xref linkend="opt-home.file._name_.source"/>
          must be set.
        '';
      };

      source = mkOption {
        type = types.path;
        description = ''
          Path of the source file or directory. If
          <xref linkend="opt-home.file._name_.text"/>
          is non-null then this option will automatically point to a file
          containing that text.
        '';
      };
    };

    config = {
      target = mkDefault name;
      source = mkIf (config.text != null) (
        mkDefault (pkgs.writeTextFile {
          inherit (config) text;
          executable = true; # can be null
          name = storeFileName name;
        })
      );
    };
  }
))