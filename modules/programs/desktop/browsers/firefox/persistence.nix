{ lib, user, ... }:
with lib; mkPersistDirsModule user [
  ".mozilla/firefox"
  ".mozilla/native-messaging-hosts"
  (ls "tor-browser")
]