{ util, lib, self, path, inputs, constant, ... }@args: components:
with lib; let
  _parser = mapAttrsToList (name: value:
    if builtins.isFunction value
    then value
    else if builtins.isAttrs value && value != {}
    then _parser value
  );
in
lib.forEach components.use (elem:
  if builtins.isFunction elem
  then elem
  else if builtins.isAttrs elem && elem != {}
  then _parser elem
  else ({...}: {})
)