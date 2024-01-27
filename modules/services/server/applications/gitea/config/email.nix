{ ... }:
{
  utils.gitea = {
    mailer.ENABLED = false;
    admin.DEFAULT_EMAIL_NOTIFICATIONS = false;

    service = {
      # NO_REPLY_ADDRESS = cfg.domain;
      REGISTER_EMAIL_CONFIRM = false;
      ENABLE_NOTIFY_MAIL = false;
    };
  };
}