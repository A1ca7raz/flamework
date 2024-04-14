{ tools, user, ... }:
with tools; mkPersistDirsModule user [
  ".mozilla/firefox"
  ".mozilla/native-messaging-hosts"
  (ls "tor-browser")
]