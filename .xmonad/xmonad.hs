import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import XMonad.Util.Run(spawnPipe)
import qualified Data.Map as M

myModMask = mod4Mask -- Use Super instead of Alt

myConfig = desktopConfig
        { modMask = myModMask
        , terminal = "urxvt +bc +vb -sb -fg white -bg black -fn 'xft:Inconsolata:pixelsize=14' -cr orange -fade 50"
        , borderWidth = 3
        , focusedBorderColor = "#FFB000" -- Orange-ish color
        , normalBorderColor = "#404040"
        }
         `additionalKeys`
        [ ((myModMask .|. shiftMask, xK_z), spawn "xset dpms force off; slock")
        --take a screenshot of entire display
        , ((myModMask, xK_Print), spawn "scrot screenshot--%Y-%m-%d-%H-%M-%S.png")
        --take a screenshot of focused window
        , ((myModMask .|. shiftMask, xK_Print), spawn "scrot -u screenshot--%Y-%m-%d-%H-%M-%S--window.png")
        , ((myModMask .|. shiftMask, xK_F11), spawn "setxkbmap -layout ru")
        , ((myModMask .|. shiftMask, xK_F12), spawn "setxkbmap -layout us")
        , ((myModMask .|. shiftMask, xK_v), spawn "pavucontrol")
        , ((myModMask .|. shiftMask, xK_Page_Up), spawn "amixer -D pulse set Master 5%+")
        , ((myModMask .|. shiftMask, xK_Page_Down), spawn "amixer -D pulse set Master 5%-")
        , ((myModMask .|. shiftMask, xK_End), spawn "amixer -D pulse set Master toggle")
        , ((0, 0x1008FF11), spawn "amixer -D pulse set Master 5%-")
        , ((0, 0x1008FF13), spawn "amixer -D pulse set Master 5%+")
        , ((0, 0x1008FF12), spawn "amixer -D pulse set Master toggle")
        ]
         `additionalKeysP`
        [ ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%-")
        , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+")
        ]

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ myConfig
        { manageHook = manageDocks <+> manageHook myConfig
        , layoutHook = avoidStruts  $  layoutHook myConfig
        , startupHook = setWMName "LG3D"
        }
