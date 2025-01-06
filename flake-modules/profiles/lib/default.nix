lib:
with builtins;
foldl'
  (acc: f:
    acc //
    (import ./${f} lib)
  )
  {}
  (
    filter
      (f: f != "default.nix")
      (attrNames (readDir ./.))
  )
