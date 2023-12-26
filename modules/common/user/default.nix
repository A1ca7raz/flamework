{ pkgs, user, ... }:
{
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.fish;
  };

  environment.persistence."/nix/persist".users.${user}.directories = [
    # Home
    "Desktop" "Documents" "Downloads"
    "Music"   "Pictures"  "Videos"
  ];
}