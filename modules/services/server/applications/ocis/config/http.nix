{ ... }:
{
  utils.ocis.proxy = {
    http = {
      addr =  "127.0.0.1:60002";
      tls = false;
    };
    oidc.insecure = false;
    insecure_backends = false;
    role_assignment = {
      driver = "oidc";
      oidc_role_mapper = {
        role_claim = "roles";
        role_mapping = [
          { role_name = "admin";
            claim_value = "admin"; }
          { role_name = "spaceadmin";
            claim_value = "spaceadmin"; }
          { role_name = "user";
            claim_value = "user"; }
          { role_name = "guest";
            claim_value = "guest"; }
        ];
      };
    };
  };
}