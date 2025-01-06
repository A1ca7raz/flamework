lib:
{
  mkItem = g: k: v: { inherit g k v; };
  mkRule = f: g: k: v: { inherit f g k v; };
}