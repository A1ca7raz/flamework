{ tools, user, ... }:
with tools; mkPersistDirsModule user [
  ".mozilla/firefox"
  (ls "tor-browser")
]