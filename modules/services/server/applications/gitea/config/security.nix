{ config, ... }:
let
  inherit (config.sops) placeholder;
in {
  utils.gitea = {
    server.OFFLINE_MODE = true;
    log.LEVEL = "Error";

    security = {
      INSTALL_LOCK = true;
      SECRET_KEY = placeholder.gitea_secret_key;
      COOKIE_USERNAME = "vl9s08hj";
      COOKIE_REMEMBER_NAME = "as2qw5r2";

      INTERNAL_TOKEN = placeholder.gitea_internal_token;

      PASSWORD_COMPLEXITY = "lower,upper,digit";
    };

    service = {
      ALLOW_ONLY_EXTERNAL_REGISTRATION = true;
      DEFAULT_ALLOW_CREATE_ORGANIZATION = true;
      DEFAULT_ENABLE_TIMETRACKING = true;
      DEFAULT_KEEP_EMAIL_PRIVATE = true;
      DISABLE_REGISTRATION = true;
      ENABLE_CAPTCHA = false;
      REQUIRE_SIGNIN_VIEW = false;
      SHOW_REGISTRATION_BUTTON = false;
      SHOW_MILESTONES_DASHBOARD_PAGE = false;
    };

    "service.explore" = {
      REQUIRE_SIGNIN_VIEW = true;
      DISABLE_USERS_PAGE = true;
    };

    session = {
      COOKIE_SECURE = true;
      COOKIE_NAME = "d8s9ajcq";
    };
  };
}