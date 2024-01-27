{ ... }:
{
  utils.gitea = {
    # Disable OAuth2 provider
    oauth2.ENABLE = false;

    oauth2_client = {
      REGISTER_EMAIL_CONFIRM = false;
      ENABLE_AUTO_REGISTRATION = true;
      UPDATE_AVATAR = true;
      ACCOUNT_LINKING = "auto";
      USERNAME = "nickname";
    };
  };
}