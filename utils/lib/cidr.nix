lib:
with builtins; with lib;
let
  regex = {
    ip4 = "^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$";
    # ip4cidr = "^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\/(3[0-2]|[1-2]?[0-9])$";
    ip6 = "^(([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|(([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)))$";
    # ip6cidr = "^(([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|(([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)))(\/(12[0-8]|1[01][0-9]|[1-9]?[0-9]))$";
  };

  # Convert CIDR number to subnet mask
  toIpv4SubnetMask = cidr:
    let
      # Helper function to convert a binary string to an integer
      binStrToOctInt = binaryString:
        foldl'
          (acc: bit: acc * 2 + bit)
          0
          (map (bit: if bit == "1" then 1 else 0) binaryString);

      # Generate the binary representation of the subnet mask
      binaryMask = map (i: if i < cidr then "1" else "0") (range 0 31);

      # Split the binary mask into four 8-bit groups
      binaryGroups = map (i: take 8 (drop (i * 8) (binaryMask))) (range 0 3);

      # Convert each 8-bit group to an integer
      decimalGroups = map binStrToOctInt binaryGroups;
    in
      # Join the decimal groups into a subnet mask string
      concatStringsSep "." (map toString decimalGroups);
in {
  removeCIDRSuffix = ip: elemAt (split "/([0-9]+)$" ip) 0;

  removeCIDRSuffixes = ips: forEach ips removeCIDRSuffix;

  cidr = cidr:
    let
      _split = splitString "/" cidr;
      _split_len = length _split;

      _mask =
        if _split_len == 1
        then null
        else if _split_len == 2
        then toInt (elemAt _split 1)
        else assertMsg false "Invalid CIDR format";
    in rec {
      inherit cidr;
      ip = elemAt _split 0;

      type =
        if isList (match regex.ip4 ip)
        then "ipv4"
        else if isList (match regex.ip6 ip)
        then "ipv6"
        else assertMsg false "Invalid IP Address";
      
      isIpv4 = if type == "ipv4" then true else false;
      isIpv6 = if type == "ipv6" then true else false;

      ipParts =
        if isIpv4
        then splitString "." ip
        else splitString ":" ip;
      
      maskCode =
        if isIpv4
        then
          if isNull _mask
          then 24
          else if _mask >= 0 && _mask <= 32
          then _mask
          else assertMsg false "Invalid network mask"
        else
          if isNull _mask
          then 64
          else if _mask >= 0 && _mask <= 128
          then _mask
          else assertMsg false "Invalid network mask";
      
      # fullMask
      networkMask =
        if isIpv4
        then toIpv4SubnetMask maskCode
        else null;  # NOTE: too lazy to transfer IPv6 cidr mask to netmask
    };
}