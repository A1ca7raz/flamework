{ util, user, ... }:
with util; mkOverlayModule user {
  kwinrules = {
    target = c "kwinrulesrc";
    text = ''
      [$Version]
      update_info=kwinrules.upd:replace-placement-string-to-enum,kwinrules.upd:use-virtual-desktop-ids

      [General]
      count=1
      rules=e8c3371f-314f-45f5-93d1-24fbe2d32a69

      [e8c3371f-314f-45f5-93d1-24fbe2d32a69]
      Description=Steam 窗口阴影
      snoborderrule=2
      types=1
      wmclass=steamwebhelper steam
      wmclasscomplete=true
      wmclassmatch=1
    '';
  };
}