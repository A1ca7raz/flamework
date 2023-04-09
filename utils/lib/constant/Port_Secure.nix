let
  port_set = {
    https = 443;
  };
  port_set_s = {
    ssh = 8022;
    http = 8080;
  };
in
{
  port = port_set // {
    secure = port_set_s;
  };
}