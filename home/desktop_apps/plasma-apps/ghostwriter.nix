{ ... }:
{
  xdg.configFile = {
    ghostwriter_conf = {
      target = "ghostwriter/ghostwriter.conf";
      text = ''
        [Application]
        locale=zh

        [FindReplace]
        highlightMatches=false
        matchCase=false
        regularExpression=false
        wholeWord=false

        [Preview]
        codeFont="Noto Sans Mono,12,-1,5,50,0,0,0,0,0"
        htmlPreviewOpen=false
        lastUsedExporter=cmark
        textFont="Noto Sans,12,-1,5,50,0,0,0,0,0"

        [Save]
        autoSave=true
        backupFile=true

        [Session]
        favoriteStatistic=0
        rememberFileHistory=false
        restoreSession=false

        [Spelling]
        liveSpellCheck=false
        locale=zh_CN

        [Style]
        blockquoteStyle=false
        darkModeEnabled=false
        displayTimeInFullScreen=true
        editorFont="Noto Sans Mono,12,-1,5,50,0,0,0,0,0"
        editorWidth=1
        focusMode=4
        hideMenuBarInFullScreenEnabled=true
        interfaceStyle=0
        largeHeadings=true
        theme=MyTheme
        underlineInsteadOfItalics=false

        [Tabs]
        insertSpacesForTabs=true
        tabWidth=4

        [Typing]
        autoMatchEnabled=true
        autoMatchFilter=\"'([{*_`<
        bulletPointCyclingEnabled=true
      '';
    };

    ghostwriter_mytheme = {
      target = "ghostwriter/themes/Mytheme.json";
      text = ''
        {
          "dark": {
            "accent": "#006c78",
            "background": "#1a1a1a",
            "block": "#ffaa00",
            "cursor": "#b31771",
            "emphasis": "#f0f0f0",
            "error": "#b31771",
            "foreground": "#d0d0d0",
            "heading": "#6488ad",
            "link": "#3daee9",
            "markup": "#575b6e",
            "selection": "#2c4464"
          },
          "light": {
            "accent": "#8daa8d",
            "background": "#ffffff",
            "block": "#e69600",
            "cursor": "#c23184",
            "emphasis": "#36495e",
            "error": "#c23184",
            "foreground": "#14191a",
            "heading": "#3d536a",
            "link": "#3daee9",
            "markup": "#c4e4f1",
            "selection": "#dbe3ea"
          }
        }
      '';
    };
  };
}