{ util, lib, self, path, inputs, ... }:
{
  name,
  system ? "x86_64-linux",
  activeModules ? [],
  components ? {},
  extraConfiguration ? {},
  ...
}:
let
  component_path = /${path}/components;

  components_common = util.foldGetFile /${component_path}/__common [] (x: y:
    if util.isNix x
    then [ (util.removeNix x) ] ++ y else y
  );

  components_optional = util.foldGetFile component_path [] (x: y:
    if util.isNix x
    then [ (util.removeNix x) ] ++ y else y
  );

  # Input Validation
  _blacklist = (x:
    assert lib.assertMsg ((lib.intersectLists components_common x) == x)
      "Non-existent component in blacklist.\nCheck the component blacklist of Profile ${name} and try again";
    lib.subtractLists x components_common)
    (lib.attrByPath ["blacklist"] [] components);

  _optionalComponents = (x:
    assert lib.assertMsg ((lib.intersectLists components_optional x) == x)
      "Non-existent component in optionalComponents.\nCheck the component blacklist of Profile ${name} and try again";
    x)
    (lib.attrByPath ["optionalComponents"] [] components);

in {
  modules = (lib.forEach _blacklist (x: /${component_path}/__common/${x}.nix )) ++
    (lib.forEach _optionalComponents (x: /${component_path}/${x}.nix ));
}