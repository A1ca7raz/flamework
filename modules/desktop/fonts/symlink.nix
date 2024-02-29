{ home, lib, ... }:
{
  # NOTE: Steam needs this to display Chinese
  home.activation.fontsSymlink = lib.hm.dag.entryAfter ["writeBoundary"] ''
    [[ -L $HOME/.local/share/fonts ]] || \
    run ln -s $VERBOSE_ARG \
      /run/current-system/sw/share/X11/fonts $HOME/.local/share/fonts
  '';
}