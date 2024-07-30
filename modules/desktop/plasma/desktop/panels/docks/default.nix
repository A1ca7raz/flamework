{ config, lib, ... }:
with lib; let
  inherit (config.lib.appletsrc) monitorIds;
  utils = import ../_utils lib;

  applets = import ./applets.nix;

  mkDockPanel = id: [
    (mkItem ["PlasmaViews" "Panel ${toString (id + 5)}"] "alignment" "1")
    (mkItem ["PlasmaViews" "Panel ${toString (id + 5)}"] "floating" "1")
    (mkItem ["PlasmaViews" "Panel ${toString (id + 5)}"] "panelLengthMode" "1")
    (mkItem ["PlasmaViews" "Panel ${toString (id + 5)}"] "panelVisibility" "1")
    (mkItem ["PlasmaViews" "Panel ${toString (id + 5)}" "Defaults"] "thickness" "50")
  ];
in with utils; {
  # Id=*5 for dock
  utils.kconfig.files.plasmashellrc.items = flatten (forEach monitorIds mkDockPanel);

  utils.kconfig.files.appletsrc.items = with applets; (mkAppletPanel ((elemAt monitorIds 0) + 5) 1 4 [
    kickOff
    colorizer
    iconTasks
  ]) ++ (mkAppletPanel ((elemAt monitorIds 1) + 5) 2 4 [
    kickOff
    colorizer
    iconTasks
  ]);
}
