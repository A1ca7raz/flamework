{ lib, pkgs }:
# https://github.com/nix-community/home-manager/blob/master/modules/lib/file-type.nix
let
  inherit (lib) hasPrefix literalExpression mkDefault mkIf mkOption removePrefix types;
  storeFileName = (import ./lib.nix { inherit lib; }).storeFileName;
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

      executable = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = ''
          Set the execute bit. If <literal>null</literal>, defaults to the mode
          of the <varname>source</varname> file or to <literal>false</literal>
          for files created through the <varname>text</varname> option.
        '';
      };

      recursive = mkOption {
        type = types.bool;
        default = false;
        description = ''
          If the file source is a directory, then this option
          determines whether the directory should be recursively
          linked to the target location. This option has no effect
          if the source is a file.
          </para><para>
          If <literal>false</literal> (the default) then the target
          will be a symbolic link to the source directory. If
          <literal>true</literal> then the target will be a
          directory structure matching the source's but whose leafs
          are symbolic links to the files of the source directory.
        '';
      };

      force = mkOption {
        type = types.bool;
        default = false;
        visible = false;
        description = ''
          Whether the target path should be unconditionally replaced
          by the managed file source. Warning, this will silently
          delete the target regardless of whether it is a file or
          link.
        '';
      };
    };

    config = {
      target = mkDefault name;
      source = mkIf (config.text != null) (
        mkDefault (pkgs.writeTextFile {
          inherit (config) executable text;
          name = storeFileName name;
        })
      );
    };
  }
))