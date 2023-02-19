{ ... }:
{
  environment.persistence."/nix/persist".users.nomad.directories = [
    # Home
    "Desktop"
    "Documents"
    "Downloads"
    "Music"
    "Pictures"
    "Videos"
    "Workspace"
    ".cache"
  ];
}