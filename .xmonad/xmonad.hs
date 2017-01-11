import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import qualified Data.Map as M

myModMask = mod4Mask -- Use Super instead of Alt

myConfig = desktopConfig
        { modMask = myModMask
        -- , keys = myKeys
        , terminal = "xfce4-terminal"
        , borderWidth = 3
        , focusedBorderColor = "#FFB000" -- Orange-ish color
        , normalBorderColor = "#404040"
        }
         `additionalKeys`
        [ ((myModMask .|. shiftMask, xK_z), spawn "slock")
        , ((myModMask .|. shiftMask, xK_v), spawn "pavucontrol")
        , ((myModMask .|. shiftMask, xK_F11), spawn "setxkbmap -layout ru")
        , ((myModMask .|. shiftMask, xK_F12), spawn "setxkbmap -layout us")
        , ((0, 0x1008FF11), spawn "amixer set Master 5%-")
        , ((0, 0x1008FF13), spawn "amixer set Master 5%+")
        , ((0, 0x1008FF12), spawn "amixer -D pulse set Master toggle")
        ]

main = do
  xmproc <- spawnPipe "hostname -s | /usr/bin/xmobar"
  xmonad $ myConfig
        { manageHook = manageDocks <+> manageHook myConfig
        , layoutHook = avoidStruts  $  layoutHook myConfig
        }
