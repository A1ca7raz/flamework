{ user, tools, ... }:
with tools; mkPersistDirsModule user [
  (c "menus")
  (ls "plasma")
  (ls "kwin")
]