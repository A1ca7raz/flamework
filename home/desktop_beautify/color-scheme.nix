{ ... }:
let
  color = x: ".local/share/color-schemes/${x}.colors";
in
{
  home.file = {
    MyDarkColor = {
      target = color "MyDark";
      text = ''
        [ColorEffects:Disabled]
        Color=112,111,110
        ColorAmount=0
        ColorEffect=0
        ContrastAmount=0.65
        ContrastEffect=1
        IntensityAmount=0.1
        IntensityEffect=0

        [ColorEffects:Inactive]
        ChangeSelectionColor=true
        Color=112,111,110
        ColorAmount=0.025
        ColorEffect=2
        ContrastAmount=0.1
        ContrastEffect=2
        Enable=false
        IntensityAmount=0
        IntensityEffect=0

        [Colors:Button]
        BackgroundAlternate=45,57,63
        BackgroundNormal=5,14,25
        DecorationFocus=170,170,170
        DecorationHover=150,150,150
        ForegroundActive=255,128,224
        ForegroundInactive=160,160,160
        ForegroundLink=46,184,230
        ForegroundNegative=240,1,1
        ForegroundNeutral=255,221,0
        ForegroundNormal=255,255,255
        ForegroundPositive=128,255,128
        ForegroundVisited=255,102,102

        [Colors:Selection]
        BackgroundAlternate=0,188,212
        BackgroundNormal=0,188,212
        DecorationFocus=170,170,170
        DecorationHover=150,150,150
        ForegroundActive=255,128,224
        ForegroundInactive=160,160,160
        ForegroundLink=46,184,230
        ForegroundNegative=240,1,1
        ForegroundNeutral=255,221,0
        ForegroundNormal=255,255,255
        ForegroundPositive=128,255,128
        ForegroundVisited=255,102,102

        [Colors:Tooltip]
        BackgroundAlternate=0,0,0
        BackgroundNormal=0,0,0
        DecorationFocus=170,170,170
        DecorationHover=150,150,150
        ForegroundActive=255,128,224
        ForegroundInactive=225,225,225
        ForegroundLink=46,184,230
        ForegroundNegative=240,1,1
        ForegroundNeutral=255,221,0
        ForegroundNormal=255,255,255
        ForegroundPositive=128,255,128
        ForegroundVisited=255,102,102

        [Colors:View]
        BackgroundAlternate=5,14,25
        BackgroundNormal=5,14,25
        DecorationFocus=170,170,170
        DecorationHover=150,150,150
        ForegroundActive=255,128,224
        ForegroundInactive=160,160,160
        ForegroundLink=46,184,230
        ForegroundNegative=240,1,1
        ForegroundNeutral=255,221,0
        ForegroundNormal=255,255,255
        ForegroundPositive=128,255,128
        ForegroundVisited=255,102,102

        [Colors:Window]
        BackgroundAlternate=5,14,25
        BackgroundNormal=5,14,25
        DecorationFocus=170,170,170
        DecorationHover=150,150,150
        ForegroundActive=255,128,224
        ForegroundInactive=160,160,160
        ForegroundLink=46,184,230
        ForegroundNegative=240,1,1
        ForegroundNeutral=255,221,0
        ForegroundNormal=255,255,255
        ForegroundPositive=128,255,128
        ForegroundVisited=255,102,102

        [General]
        ColorScheme=KvAdaptaDark
        Name=MyDark
        shadeSortColumn=true

        [KDE]
        contrast=0

        [WM]
        activeBackground=5,14,25
        activeBlend=5,14,25
        activeForeground=255,255,255
        inactiveBackground=5,14,25
        inactiveBlend=5,14,25
        inactiveForeground=200,200,200
      '';
    };

    MyLightColor = {
      target = color "MyLight";
      text = ''
        [ColorEffects:Disabled]
        Color=56,56,56
        ColorAmount=0
        ColorEffect=0
        ContrastAmount=0.65
        ContrastEffect=1
        IntensityAmount=0.1
        IntensityEffect=2

        [ColorEffects:Inactive]
        ChangeSelectionColor=true
        Color=112,111,110
        ColorAmount=0.025
        ColorEffect=2
        ContrastAmount=0.1
        ContrastEffect=2
        Enable=false
        IntensityAmount=0
        IntensityEffect=0

        [Colors:Button]
        BackgroundAlternate=189,195,199
        BackgroundNormal=239,240,241
        DecorationFocus=61,174,233
        DecorationHover=147,206,233
        ForegroundActive=61,174,233
        ForegroundInactive=67,73,74
        ForegroundLink=41,128,185
        ForegroundNegative=255,85,127
        ForegroundNeutral=0,128,128
        ForegroundNormal=0,0,0
        ForegroundPositive=39,174,96
        ForegroundVisited=127,140,141

        [Colors:Complementary]
        BackgroundAlternate=59,64,69
        BackgroundNormal=49,54,59
        DecorationFocus=30,146,255
        DecorationHover=61,174,230
        ForegroundActive=147,206,233
        ForegroundInactive=175,176,179
        ForegroundLink=61,174,230
        ForegroundNegative=231,76,60
        ForegroundNeutral=253,188,75
        ForegroundNormal=253,254,255
        ForegroundPositive=46,204,113
        ForegroundVisited=61,174,230

        [Colors:Selection]
        BackgroundAlternate=29,153,243
        BackgroundNormal=61,174,233
        DecorationFocus=61,174,233
        DecorationHover=147,206,233
        ForegroundActive=252,252,252
        ForegroundInactive=239,240,241
        ForegroundLink=253,188,75
        ForegroundNegative=255,85,127
        ForegroundNeutral=0,128,128
        ForegroundNormal=252,252,252
        ForegroundPositive=39,174,96
        ForegroundVisited=189,195,199

        [Colors:Tooltip]
        BackgroundAlternate=52,158,206
        BackgroundNormal=61,174,233
        DecorationFocus=61,174,233
        DecorationHover=147,206,233
        ForegroundActive=61,174,233
        ForegroundInactive=67,73,74
        ForegroundLink=41,128,185
        ForegroundNegative=255,85,127
        ForegroundNeutral=0,128,128
        ForegroundNormal=0,0,0
        ForegroundPositive=39,174,96
        ForegroundVisited=127,140,141

        [Colors:View]
        BackgroundAlternate=239,240,241
        BackgroundNormal=255,255,255
        DecorationFocus=61,174,233
        DecorationHover=147,206,233
        ForegroundActive=61,174,233
        ForegroundInactive=21,23,24
        ForegroundLink=41,128,185
        ForegroundNegative=255,85,127
        ForegroundNeutral=0,128,128
        ForegroundNormal=0,0,0
        ForegroundPositive=39,174,96
        ForegroundVisited=127,140,141

        [Colors:Window]
        BackgroundAlternate=189,195,199
        BackgroundNormal=255,255,255
        DecorationFocus=61,174,233
        DecorationHover=147,206,233
        ForegroundActive=61,174,233
        ForegroundInactive=67,73,74
        ForegroundLink=41,128,185
        ForegroundNegative=255,85,127
        ForegroundNeutral=0,128,128
        ForegroundNormal=0,0,0
        ForegroundPositive=39,174,96
        ForegroundVisited=127,140,141

        [General]
        ColorScheme=Blur-Glassy
        Name=MyLight
        shadeSortColumn=true

        [KDE]
        contrast=0

        [WM]
        activeBackground=255,255,255
        activeBlend=255,255,255
        activeForeground=0,0,0
        inactiveBackground=255,255,255
        inactiveBlend=255,255,255
        inactiveForeground=53,53,53
      '';
   };
  };
}