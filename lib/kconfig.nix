lib:
let
  inherit (lib)
    updateManyAttrsByPath
  ;

  inherit (builtins)
    isList
    map
    concatStringsSep
  ;
in {
  convertItemsToKconfig = items:
    let
      updatePaths = map (i:
        let
          _g = if isList i.g then i.g else [ i.g ];
          group = concatStringsSep "/" _g;
        in {
          path = [ group i.k ];
          update = old: i.v;
        }
      ) items;
    in
      updateManyAttrsByPath updatePaths {}
    ;

  mkItem = g: k: v: { inherit g k v; };
  mkRule = f: g: k: v: { inherit f g k v; };
}
