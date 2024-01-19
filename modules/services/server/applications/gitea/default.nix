{ lib, ... }:
{
  services.gitea = {
    enable = true;
    
    httpAddress = "127.0.0.1";
    appName = "Alca7raz's GitBucket";
    domain = lib.mkDefault "git.pwd.moe";
    
    useWizard = true;

    database = {
      type = "postgres";
      # user = "gitea";
      # name = "gitea";
      # host = "localhost";
    };
  };
}