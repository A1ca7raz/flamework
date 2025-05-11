lib:
let
  inherit (lib)
    flip
    genAttrs
  ;
in {
  # Pre-defined tags
  tags = flip genAttrs (x: x) [
    "desktop" "server"

    "local" "remote"  # Proximity to user or system

    "internal" "external"  # Network location and accessibility

    "public" "private"  # Visibility and access control

    "physical" "virtual"

    "laptop"

    "debug"
  ];
}
