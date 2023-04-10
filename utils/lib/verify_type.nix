{ lib, ...}:
let
  _try = func: msg: try:
    lib.throwIfNot (func try) "value is a ${builtins.typeOf try} while ${msg} is expected." try;

  mkTry = x: y: _try builtins."is${x}" y;
in rec {
  try_attrs = mkTry "Attrs" "an attrset";
  try_bool = mkTry "Bool" "a bool";
  try_float = mkTry "Float" "a float";
  try_func = mkTry "Function" "a function";
  try_int = mkTry "Int" "an integer";
  try_list = mkTry "List" "a list";
  try_nix = x: _try (lib.hasSuffix ".nix") "a nix file" (try_str x);
  try_null = mkTry "Null" "a null";
  try_path = mkTry "Path" "a path";
  try_str = mkTry "String" "a string";
}