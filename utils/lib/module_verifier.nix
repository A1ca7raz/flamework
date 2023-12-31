lib:
with lib; with builtins; {
  # Home-manager Module
  isHomeModule = x:
    isFunction x &&
    ! mutuallyExclusive ["home"] (attrNames (functionArgs x));

  # NixosModule
  isNixosModule = x:
    isFunction x &&
    mutuallyExclusive ["user" "home"] (attrNames (functionArgs x));

  # NixosModule with arg user
  isNixosModuleUser = x:
    isFunction x &&
    ! mutuallyExclusive ["user"] (attrNames (functionArgs x));

  # Hybrid module with NixosModule and Home-manager module
  isHybridModule = x: isAttrs x && x ? nixosModule || x ? homeModule;

  # Set of modules
  isModuleSet = x:
    isAttrs x &&
    hasAttrByPath [ "__isModuleSet__" ] x &&
    x.__isModuleSet__ == true;
}