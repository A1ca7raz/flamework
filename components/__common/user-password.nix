{ config, ... }:
{
  # users.users.root.passwordFile = config.sops.secrets.rootpwd.path;
  users.users.root.password = "asdd";
}