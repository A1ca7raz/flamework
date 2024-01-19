{ ... }:
{
  security.pam.services.login = {
    enableKwallet = true;
    rules.session.kwallet5.settings.auto_start = true;
  };
}