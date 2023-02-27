{ ... }:
{
  environment.persistence."/nix/persist".users.nomad = {
    directories = [
      ".config/autostart"
      ".ssh"
    ];
  };
}