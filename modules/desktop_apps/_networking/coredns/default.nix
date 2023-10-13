{ ... }:
{
  services.coredns = {
    enable = false;
    config = builtins.readFile ./Corefile;
  };
}