{
  lib,
  tdesktop,
  fetchpatch
}:
let
  patch01 = fetchpatch {
    url = "https://raw.githubusercontent.com/archlinuxcn/repo/master/archlinuxcn/telegram-desktop-megumifox/0001-Use-font-from-environment-variables.patch";
    hash = "sha256-D2FDXCxMhJ8kie8E/Z+yxU6WKXzCQ5gcGsSWsdBnWSA=";
  };
  patch02 = fetchpatch {
    url = "https://raw.githubusercontent.com/archlinuxcn/repo/master/archlinuxcn/telegram-desktop-megumifox/0002-add-TDESKTOP_DISABLE_REGISTER_CUSTOM_SCHEME-back.patch";
    hash = "sha256-3PP3i7APchxUn5HbhW1qG7xyDcAjodiRhFO+c9NUrw0=";
  };
in
tdesktop.overrideAttrs (final: pre: {
  patchFlags = "-l -N";
  prePatch = ''
    patch -b -d Telegram/lib_ui/ -Np1 -i ${patch01}
    patch -b -l -Np1 -i ${patch02}
  '';
})