{ config, ... }:
{
  utils.gitea = {
    # Disable OAuth2 provider
    oauth2 = {
      ENABLE = false;
      JWT_SECRET = config.sops.placeholder."gitea/oauth2_jwt_secret";
    };

    oauth2_client = {
      REGISTER_EMAIL_CONFIRM = false;
      ENABLE_AUTO_REGISTRATION = true;
      UPDATE_AVATAR = true;
      ACCOUNT_LINKING = "auto";
      USERNAME = "nickname";
    };
  };
}