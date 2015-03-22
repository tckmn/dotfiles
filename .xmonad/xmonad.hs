import XMonad
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86

main = xmonad $ defaultConfig 
    {
        terminal = "gnome-terminal",
        borderWidth = 3
    }
    `additionalKeysP` [
        ("<Print>",   spawn "import -window root $(date '+Pictures/screenshot_%Y-%m-%d_%H:%M:%S.png')"),
        ("M-<Print>", spawn "import $(date '+Pictures/screenshot_%Y-%m-%d_%H:%M:%S.png')"),
        ("M-s", spawn "~/.xmonad/toggle-dzen.sh")
    ]
    `additionalKeys` [
        ((0, xF86XK_AudioLowerVolume), spawn "amixer -D pulse set Master 5%-"),
        ((0, xF86XK_AudioRaiseVolume), spawn "amixer -D pulse set Master 5%+"),
        ((0, xF86XK_AudioMute), spawn "amixer -D pulse set Master toggle"),
        -- these ones are weird because my laptop is weird (found via xev)
        ((0, xF86XK_Sleep), spawn "xbacklight +10%"),
        ((0, 0x1008ff93), spawn "xbacklight -10%")
    ]
