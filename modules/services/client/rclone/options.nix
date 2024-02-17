builtins.concatStringsSep " " [
  "--multi-thread-streams 64"
  "--multi-thread-cutoff 128M"
  "--vfs-cache-mode full"
  "--vfs-cache-max-size 100G"
  "--vfs-cache-max-age 6h"
  "--vfs-read-chunk-size-limit off"
  "--buffer-size 128M"
  "--vfs-read-chunk-size 128M"
  "--vfs-read-wait 0ms"
]