lib:
with lib; with builtins; rec {
  # Home-manager Module with arg user
  isHomeModuleUser = x:
    isFunction x &&
    (intersectLists (attrNames (functionArgs x)) ["user" "home"] == ["user" "home"]);

  # Home-manager Module
  isHomeModule = x:
    isFunction x &&
    (intersectLists (attrNames (functionArgs x)) ["user" "home"] == ["home"]);

  # NixosModule
  isNixosModule = x:
    isFunction x &&
    mutuallyExclusive ["user" "home"] (attrNames (functionArgs x));

  # NixosModule with arg user
  isNixosModuleUser = x:
    isFunction x && ! isHomeModule x &&
    (intersectLists (attrNames (functionArgs x)) ["user" "home"] == ["user"]);

  # Hybrid module with NixosModule and Home-manager module
  isHybridModule = x: isAttrs x && x ? nixosModule || x ? homeModule;

  # Set of modules
  isModuleSet = x:
    isAttrs x &&
    hasAttrByPath [ "__isModuleSet__" ] x &&
    x.__isModuleSet__ == true;
}