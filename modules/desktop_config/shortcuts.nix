{ lib, tools, pkgs, ... }:
let
  wc = tools.wrapWC pkgs "kglobalshortcutsrc";
in {
  home.activation.setupShortcuts = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${wc "kaccess" "Toggle Screen Reader On and Off" "none,Meta+Alt+S,切换屏幕阅读器开关"}
    ${wc "kcm_touchpad" "Toggle Touchpad" "Meta+Ins\tTouchpad Toggle,Touchpad Toggle,切换触摸板"}
    ${wc "kwin" "Expose" "none,Ctrl+F9,显示/隐藏窗口平铺 (当前桌面)"}
    ${wc "kwin" "ExposeClass" "none,Ctrl+F7,显示/隐藏窗口平铺 (窗口类)"}
    ${wc "kwin" "MinimizeAll" "Meta+D,none,MinimizeAll"}
    ${wc "kwin" "MoveMouseToCenter" "none,Meta+F6,移动鼠标到中央"}
    ${wc "kwin" "Show Desktop" "none,Meta+D,暂时显示桌面"}
    ${wc "kwin" "Switch to Desktop 1" "Meta+1,Ctrl+F1,切换到桌面 1"}
    ${wc "kwin" "Switch to Desktop 2" "Meta+2,Ctrl+F2,切换到桌面 2"}
    ${wc "kwin" "Switch to Desktop 3" "Meta+3,Ctrl+F3,切换到桌面 3"}
    ${wc "kwin" "Switch to Desktop 4" "Meta+4,Ctrl+F4,切换到桌面 4"}
    ${wc "kwin" "ToggleMouseClick" "none,Meta+*,打开/关闭鼠标点击动效"}
    ${wc "kwin" "Walk Through Desktops" "Meta+Tab,,遍历桌面"}
    ${wc "kwin" "Walk Through Desktops (Reverse)" "Meta+Shift+Tab,,遍历桌面(反向)"}
    ${wc "kwin" "Window to Desktop 1" "Meta+F1,,窗口到桌面 1"}
    ${wc "kwin" "Window to Desktop 2" "Meta+F2,,窗口到桌面 2"}
    ${wc "kwin" "Window to Desktop 3" "Meta+F3,,窗口到桌面 3"}
    ${wc "kwin" "Window to Desktop 4" "Meta+F4,,窗口到桌面 4"}
    ${wc "kwin" "Window to Desktop 5" "Meta+F5,,窗口到桌面 5"}
    ${wc "kwin" "Window to Desktop 6" "Meta+F6,,窗口到桌面 6"}
    ${wc "kwin" "Window to Desktop 7" "Meta+F7,,窗口到桌面 7"}
    ${wc "kwin" "Window to Desktop 8" "Meta+F8,,窗口到桌面 8"}
    ${wc "kwin" "Window to Desktop 9" "Meta+F9,,窗口到桌面 9"}
    ${wc "kwin" "Window to Next Screen" "none,Meta+Shift+Right,窗口到下一屏幕"}
    ${wc "kwin" "Window to Previous Screen" "none,Meta+Shift+Left,窗口到前一屏幕"}
    ${wc "kwin" "view_actual_size" "none,Meta+0,缩放为实际大小(A)"}
    ${wc "kwin" "view_zoom_in" "none,Meta++,放大(I)"}
    ${wc "kwin" "view_zoom_out" "none,Meta+-,缩小(O)"}
    ${wc "lattedock" "activate entry 1" "none,Meta+1,激活项目 1"}
    ${wc "lattedock" "activate entry 2" "none,Meta+2,激活项目 2"}
    ${wc "lattedock" "activate entry 3" "none,Meta+3,激活项目 3"}
    ${wc "lattedock" "activate entry 4" "none,Meta+4,激活项目 4"}
    ${wc "lattedock" "activate entry 5" "none,Meta+5,激活项目 5"}
    ${wc "lattedock" "activate entry 6" "none,Meta+6,激活项目 6"}
    ${wc "lattedock" "activate entry 7" "none,Meta+7,激活项目 7"}
    ${wc "lattedock" "activate entry 8" "none,Meta+8,激活项目 8"}
    ${wc "lattedock" "activate entry 9" "none,Meta+9,激活项目 9"}
    ${wc "lattedock" "activate entry 10" "none,Meta+0,激活项目 10"}
    ${wc "lattedock" "activate entry 11" "none,Meta+Z,激活项目 11"}
    ${wc "lattedock" "activate entry 12" "none,Meta+X,激活项目 12"}
    ${wc "lattedock" "activate entry 13" "none,Meta+C,激活项目 13"}
    ${wc "lattedock" "activate entry 14" "none,Meta+V,激活项目 14"}
    ${wc "lattedock" "activate entry 15" "none,Meta+B,激活项目 15"}
    ${wc "lattedock" "activate entry 16" "none,Meta+N,激活项目 16"}
    ${wc "lattedock" "activate entry 17" "none,Meta+M,激活项目 17"}
    ${wc "lattedock" "activate entry 18" "none,Meta+\\,,激活项目 18"}
    ${wc "lattedock" "activate entry 19" "none,Meta+.,激活项目 19"}
    ${wc "lattedock" "clipboard_action" "none,Meta+Ctrl+X,自动弹出操作菜单"}
    ${wc "lattedock" "new instance for entry 1" "none,Meta+Ctrl+1,为项目 1 建立新实例"}
    ${wc "lattedock" "new instance for entry 2" "none,Meta+Ctrl+2,为项目 2 建立新实例"}
    ${wc "lattedock" "new instance for entry 3" "none,Meta+Ctrl+3,为项目 3 建立新实例"}
    ${wc "lattedock" "new instance for entry 4" "none,Meta+Ctrl+4,为项目 4 建立新实例"}
    ${wc "lattedock" "new instance for entry 5" "none,Meta+Ctrl+5,为项目 5 建立新实例"}
    ${wc "lattedock" "new instance for entry 6" "none,Meta+Ctrl+6,为项目 6 建立新实例"}
    ${wc "lattedock" "new instance for entry 7" "none,Meta+Ctrl+7,为项目 7 建立新实例"}
    ${wc "lattedock" "new instance for entry 8" "none,Meta+Ctrl+8,为项目 8 建立新实例"}
    ${wc "lattedock" "new instance for entry 9" "none,Meta+Ctrl+9,为项目 9 建立新实例"}
    ${wc "lattedock" "new instance for entry 10" "none,Meta+Ctrl+0,为项目 10 建立新实例"}
    ${wc "lattedock" "new instance for entry 11" "none,Meta+Ctrl+Z,为项目 11 建立新实例"}
    ${wc "lattedock" "new instance for entry 12" "none,Meta+Ctrl+X,为项目 12 建立新实例"}
    ${wc "lattedock" "new instance for entry 13" "none,Meta+Ctrl+C,为项目 13 建立新实例"}
    ${wc "lattedock" "new instance for entry 14" "none,Meta+Ctrl+V,为项目 14 建立新实例"}
    ${wc "lattedock" "new instance for entry 15" "none,Meta+Ctrl+B,为项目 15 建立新实例"}
    ${wc "lattedock" "new instance for entry 16" "none,Meta+Ctrl+N,为项目 16 建立新实例"}
    ${wc "lattedock" "new instance for entry 17" "none,Meta+Ctrl+M,为项目 17 建立新实例"}
    ${wc "lattedock" "new instance for entry 18" "none,Meta+Ctrl+\\,,为项目 18 建立新实例"}
    ${wc "lattedock" "new instance for entry 19" "none,Meta+Ctrl+.,为项目 19 建立新实例"}
    ${wc "lattedock" "show latte view" "none,Meta+`,显示 Latte 停靠栏/面板"}
    ${wc "lattedock" "show view settings" "none,Meta+A,循环切换停靠栏/面板的设置窗口"}
    ${wc "lattedock" "show-on-mouse-pos" "none,Meta+V,在鼠标光标位置弹出 Klipper"}
    ${wc "mediacontrol" "nextmedia" "Media Next\tMeta+Alt+X,Media Next,播放下一首媒体"}
    ${wc "mediacontrol" "playpausemedia" "Media Play\tMeta+Alt+Space,Media Play,播放/暂停媒体播放"}
    ${wc "mediacontrol" "previousmedia" "Media Previous\tMeta+Alt+Z,Media Previous,播放上一首媒体"}
    ${wc "org.kde.dolphin.desktop" "_launch" "Meta+A,Meta+E,Dolphin"}
    ${wc "org.kde.kate.desktop" "_launch" "Meta+X,none,Kate"}
    ${wc "org.kde.konsole.desktop" "_launch" "Meta+T,none,Konsole"}
    ${wc "org.kde.krunner.desktop" "RunClipboard" "Alt+Shift+Space,Alt+Shift+F2,Run command on clipboard contents"}
    ${wc "org.kde.krunner.desktop" "_launch" "Alt+Space\tMeta+R\tSearch,Alt+Space\tAlt+F2\tSearch,KRunner"}
    ${wc "plasmashell" "activate task manager entry 1" "none,Meta+1,激活任务管理器条目 1"}
    ${wc "plasmashell" "activate task manager entry 2" "none,Meta+2,激活任务管理器条目 2"}
    ${wc "plasmashell" "activate task manager entry 3" "none,Meta+3,激活任务管理器条目 3"}
    ${wc "plasmashell" "activate task manager entry 4" "none,Meta+4,激活任务管理器条目 4"}
    ${wc "plasmashell" "activate task manager entry 5" "none,Meta+5,激活任务管理器条目 5"}
    ${wc "plasmashell" "activate task manager entry 6" "none,Meta+6,激活任务管理器条目 6"}
    ${wc "plasmashell" "activate task manager entry 7" "none,Meta+7,激活任务管理器条目 7"}
    ${wc "plasmashell" "activate task manager entry 8" "none,Meta+8,激活任务管理器条目 8"}
    ${wc "plasmashell" "activate task manager entry 9" "none,Meta+9,激活任务管理器条目 9"}
    ${wc "plasmashell" "activate task manager entry 10" "none,Meta+0,激活任务管理器条目 10"}
    ${wc "plasmashell" "clipboard_action" "none,Ctrl+Alt+X,启用剪贴板操作"}
    ${wc "plasmashell" "cycle-panels" "none,Meta+Alt+P,在面板之间移动键盘焦点"}
    ${wc "plasmashell" "manage activities" "none,Meta+Q,显示活动切换器"}
    ${wc "plasmashell" "next activity" "none,Meta+Tab,遍历活动"}
    ${wc "plasmashell" "previous activity" "none,Meta+Shift+Tab,反向遍历活动"}
    ${wc "plasmashell" "repeat_action" "none,Ctrl+Alt+R,在当前剪贴板上手动执行操作"}
    ${wc "plasmashell" "show dashboard" "none,Ctrl+F12,显示桌面"}
    ${wc "plasmashell" "show-on-mouse-pos" "none,Meta+V,在鼠标指针处弹出 Klipper"}
    ${wc "plasmashell" "stop current activity" "none,Meta+S,停止当前活动"}
    ${wc "systemsettings.desktop" "_launch" "Meta+S\tTools,Tools,System Settings"}
    ${wc "yakuake" "toggle-window-state" "F1,F12,打开/缩回 Yakuake"}
    ${wc "chromium-browser.desktop" "_launch" "Meta+C,none,Chromium"}
    ${wc "firefox.desktop" "_launch" "Meta+F,none,Firefox"}
  '';
}