{ config, ... }:
{
  utils.gitea.server = {
    LFS_START_SERVER = true;
    LFS_JWT_SECRET = config.sops.placeholder."gitea/lfs_jwt_secret";
  };
}