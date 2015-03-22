import XMonad
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86
import Control.Concurrent

main = xmonad $ defaultConfig
    {
        terminal = "gnome-terminal",
        borderWidth = 3,
        layoutHook = avoidStruts $ layoutHook defaultConfig
    }
    `additionalKeysP` [
        ("<Print>",   spawn "import -window root $(date '+Pictures/screenshot_%Y-%m-%d_%H:%M:%S.png')"),
        ("M-<Print>", spawn "import $(date '+Pictures/screenshot_%Y-%m-%d_%H:%M:%S.png')"),
        ("M-S-s", sendMessage ToggleStruts),
        ("M-s", do
        cur <- withWindowSet (return . W.currentTag)
        spawn $ "~/.xmonad/toggle-dzen.sh " ++ cur
        liftIO $ threadDelay 100000
        sendMessage ToggleStruts)
    ]
    `additionalKeys` [
        ((0, xF86XK_AudioLowerVolume), spawn "amixer -D pulse set Master 5%-"),
        ((0, xF86XK_AudioRaiseVolume), spawn "amixer -D pulse set Master 5%+"),
        ((0, xF86XK_AudioMute), spawn "amixer -D pulse set Master toggle"),
        -- these ones are weird because my laptop is weird (found via xev)
        ((0, xF86XK_Sleep), spawn "xbacklight +10%"),
        ((0, 0x1008ff93), spawn "xbacklight -10%")
    ]
