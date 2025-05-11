lib:
let
  inherit (lib)
    isNix
    removeNix
    hasDefault
    foldFileIfExists
    updateManyAttrsByPath
    forEach
    splitString
    mapAttrs'
  ;

  inherit (builtins)
    readDir
  ;
in rec {
  _buildModuleSet = set: set // {
    "__isModuleSet__" = true;
    exclude = list: (updateManyAttrsByPath
      (forEach list (x: { path = splitString "." x; update = old: {}; }))
      set) // { "__isModuleSet__" = true; };
  };

  _mkModuleTree = type: _path:
    let
      _dir = readDir _path;
      _scanner_once = mapAttrs' (_recur _path) _dir;
      _scanner = dir:
        mapAttrs' (_recur dir) (readDir dir);

      _recur = path: n: v:
        let
          forceImportFiles = p: x: y:
            if isNix x
            then { "${removeNix x}" = import /${p}/${x}; } // y
            else y;
        in
          # 文件型模块
          if v == "regular" && isNix n && type == "file"
          then { name = removeNix n; value = import /${path}/${n}; }
          # 目录型模块，声明读取文件型模块
          else if (v == "directory" && hasDefault /${path}/${n} && (import /${path}/${n}/default.nix) == {})
          then { name = n; value = _buildModuleSet (foldFileIfExists /${path}/${n} {} (forceImportFiles /${path}/${n})); }
          else if (v == "directory" && builtins.pathExists /${path}/${n}/__.nix && (import /${path}/${n}/__.nix) == {})
          then { name = n; value = _buildModuleSet (foldFileIfExists /${path}/${n} {} (forceImportFiles /${path}/${n})); }
          # 目录型模块
          else if v == "directory" && type == "dir" && hasDefault /${path}/${n}
          then { name = n; value = import /${path}/${n}; }
          # 非模块目录，递归扫描子目录
          else if v == "directory"
          then { name = n; value = _buildModuleSet (_scanner /${path}/${n}); }
          # 无效文件,生成空模块
          else { name = removeNix n; value = {}; };
    in
      _scanner_once // { "__isModuleSet__" = true; };

  mkModuleTreeFromFiles = _mkModuleTree "file";
  mkModuleTreeFromDirs = _mkModuleTree "dir";
}
