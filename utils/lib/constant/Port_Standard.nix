let
  port_set = {
    ssh = 22;
    http = 80;
  };
in
{
  port = port_set // {
    standard = port_set;
  };
}