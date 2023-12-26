lib:
{
  test  = func: msg: try:
    lib.throwIf (func try) (builtins.toString msg) try;

  testIfNot = func: msg: try:
    lib.throwIfNot (func try) (builtins.toString msg) try;
}