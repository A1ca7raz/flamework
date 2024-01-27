{ ... }:
{
  utils.gitea.database = {
    DB_TYPE = "postgres";
    HOST = "/run/postgresql/";
    NAME = "git";
    USER = "git";
    SSL_MODE = "disable";
  };
}