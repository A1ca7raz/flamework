{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.python3 ];

  environment.shellAliases = {
    dd = "dd status=progress";
    sctl = "systemctl";
    httpd = "python3 -m http.server";
  };
}