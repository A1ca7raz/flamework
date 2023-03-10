{ ... }:
let
  c = x: ".config/" + x;
  ls = x: ".local/share/" + x;
in
{
  environment.persistence."/nix/persist".users.nomad.directories = [
    (c "direnv") (ls "direnv")  # nix-direnv
  ];
}