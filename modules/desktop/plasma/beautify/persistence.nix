{ user, tools, ... }:
with tools; mkPersistDirsModule user [
  (c "menus")
  (ls "plasmashell")
  (ls "plasma")
  (ls "kwin")
]