let
  data = builtins.fromJSON (builtins.readFile ./data.json);
in
{
  TTL = 30;
  SOA = {
    nameServer = "iad0.nichi.link.";
    adminEmail = "noc@nichi.co";
    serial = 0;
    refresh = 14400;
    retry = 3600;
    expire = 604800;
    minimum = 300;
  };
  NS = builtins.map (name: "${name}.") data.nameservers.value;
}