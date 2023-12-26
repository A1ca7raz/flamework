{ user, tools, ... }:
with tools; mkPersistDirsModule user [
  (c "Kvantum")
  (c "latte")
  (ls "latte")
  (c "menus")
  (ls "plasmashell")
  (ls "plasma")
  (ls "kwin")
]