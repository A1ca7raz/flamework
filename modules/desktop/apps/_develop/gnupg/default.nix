{ user, util, ... }:
with util; mkPersistDirsModule user [
  ".gnupg"
]