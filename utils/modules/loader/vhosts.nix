{ util, config, lib, self, path, constant, ... }:
with lib; let
  cfg = config.utils.vhosts;
  vhost_path = /${path}/config/websites;

  vhost_list = util.foldGetFile vhost_path [] (x: y:
    if util.isNix x
    then [ (util.removeNix x) ] ++ y else y
  );
in {
  options.utils.vhosts = {
    load = mkOption {
      type = with types; nullOr (listOf (enum vhost_list));
      default = [];
      description = "Profile names of the websites which will be deployed on the system.";
    };
    enableDefault = mkOption {
      type = with types; bool;
      default = true;
      description = "Profile names of the websites which will be deployed on the system.";
    };
  };

  config.services.nginx.virtualHosts = fold (x: y: rec { ${x} = import /${vhost_path}/${x}.nix; } // y) {} 
    (if cfg.enableDefault then (cfg.load ++ ["default"]) else cfg.load);
}
