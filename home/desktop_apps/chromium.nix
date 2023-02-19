{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    
    commandLineArgs = [
      "--enable-features=VaapiVideoDecoder"
      "--enable-features=VaapiIgnoreDriverChecks"
      "--enable-features=PlatformHEVCDecoderSupport"
    ];
    
    # It does not work any more.
    # extensions = [
    #   { id = "gighmmpiobklfepjocnamgkkbiglidom"; }  # AdBlock
    #   { id = "occjjkgifpmdgodlplnacmkejpdionan"; }  # AutoScroll
    #   { id = "fohimdklhhcpcnpmmichieidclgfdmol"; }  # BookmarkHub
    #   { id = "codgofkgobbmgglciccjabipdlgefnch"; }  # BTool
    #   { id = "noaijdpnepcgjemiklgfkcfbkokogabh"; }  # ImTranslate
    #   { id = "oboonakemofpalcgghocfoadofidjkkk"; }  # KeepassXC-Browser
    #   { id = "cimiefiiaegbelhefglklhhakcgmhkai"; }  # Plasma Integration
    #   { id = "padekgcemlokbadohgkifijomclgjgif"; }  # SwitchyOmega
    #   { id = "gcalenpjmijncebpfijmoaglllgpjagf"; }  # Tampermonkey BETA
    #   { id = "gppongmhjkpfnbhagpmjfkannfbllamg"; }  # Wappalyzer
    #   { id = "kpbnombpnpcffllnianjibmpadjolanh"; }  # 哔哩哔哩助手
    #   { id = "imjoocoajfjgnabmlbgpcnpieibibhmd"; }  # 百度文库免费下载
    # ];
    # Use Chromium Web Store Extension instead
    # |gighmmpiobklfepjocnamgkkbiglidom
    # |occjjkgifpmdgodlplnacmkejpdionan
    # |fohimdklhhcpcnpmmichieidclgfdmol
    # |codgofkgobbmgglciccjabipdlgefnch
    # |noaijdpnepcgjemiklgfkcfbkokogabh
    # |oboonakemofpalcgghocfoadofidjkkk
    # |cimiefiiaegbelhefglklhhakcgmhkai
    # |padekgcemlokbadohgkifijomclgjgif
    # |gcalenpjmijncebpfijmoaglllgpjagf
    # |gppongmhjkpfnbhagpmjfkannfbllamg
    # |kpbnombpnpcffllnianjibmpadjolanh
    # |imjoocoajfjgnabmlbgpcnpieibibhmd
  };
}