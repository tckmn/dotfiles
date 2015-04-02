import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86
import Control.Concurrent

goaway :: String -> String
goaway x = ""

main = xmonad =<< statusBar barCmd barPP barToggleKey myConfig
barCmd = "dzen2 -e 'onstart=lower' -fn 'monospace-20' -w 300 -ta l"
barPP = defaultPP { ppSep = " | ", ppWsSep = "", ppCurrent = dzenColor "red" "green" . pad, ppTitle = goaway }
barToggleKey XConfig { XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = defaultConfig {
        terminal = "gnome-terminal",
        borderWidth = 3
        } `additionalKeysP` [
            ("<Print>",   spawn "import -window root $(date '+Pictures/screenshot_%Y-%m-%d_%H:%M:%S.png')"),
            ("M-<Print>", spawn "import $(date '+Pictures/screenshot_%Y-%m-%d_%H:%M:%S.png')"),
            ("M-v", do
            cur <- withWindowSet (return . W.currentTag)
            spawn $ "~/.xmonad/toggle-dzen.sh " ++ cur),
            ("M-s k", spawn "xdotool key Shift+Tab Shift+Tab Shift+Tab Up Return"),
            ("M-s j", spawn "xdotool key Shift+Tab Shift+Tab Shift+Tab Down Return"),
            ("M-d", spawn "~/.xmonad/disapprove.sh")
        ] `additionalKeys` [
            ((0, xF86XK_AudioLowerVolume), spawn "amixer -D pulse set Master 5%-"),
            ((0, xF86XK_AudioRaiseVolume), spawn "amixer -D pulse set Master 5%+"),
            ((0, xF86XK_AudioMute), spawn "amixer -D pulse set Master toggle"),
            -- these ones are weird because my laptop is weird (found via xev)
            ((0, xF86XK_Sleep), spawn "xbacklight +10%"),
            ((0, 0x1008ff93), spawn "xbacklight -10%")
        ]
