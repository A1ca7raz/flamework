{ lib, ... }:
{
  throwIf  = func: msg: try: lib.throwIf (func try) msg try; 
  throwIfNot = func: msg: try: lib.throwIfNot (func try) msg try;
}