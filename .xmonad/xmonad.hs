import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import XMonad.Util.Run(spawnPipe, hPutStrLn)
import qualified Data.Map as M

myModMask = mod4Mask -- Use Super instead of Alt

myConfig = desktopConfig
    { modMask = myModMask
    , terminal = "sp-terminal.sh"
    , borderWidth = 2
    , focusedBorderColor = "#FFB000" -- Orange-ish color
    , normalBorderColor = "#404040"
    }
     `additionalKeys`
    [ ((myModMask .|. shiftMask, xK_z), spawn "xset dpms force off; slock")
    --take a screenshot of entire display
    , ((myModMask, xK_Print), spawn "scrot screenshot--%Y-%m-%d-%H-%M-%S.png")
    --take a screenshot of focused window
    , ((myModMask .|. shiftMask, xK_Print), spawn "scrot -u screenshot--%Y-%m-%d-%H-%M-%S--window.png")
    , ((myModMask .|. shiftMask, xK_equal), spawn "gnome-calculator")
    , ((myModMask .|. shiftMask, xK_KP_Enter), spawn "gnome-calculator")
    , ((myModMask .|. shiftMask, xK_backslash), spawn "xdg-open https://duckduckgo.com")
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
    [ ("<XF86AudioLowerVolume>", spawn "amixer -D pulse set Master 5%-")
    , ("<XF86AudioRaiseVolume>", spawn "amixer -D pulse set Master 5%+")
    , ("<XF86AudioMute>", spawn "amixer -D pulse set Master toggle")
    , ("<XF86Calculator>", spawn "gnome-calculator")
    , ("<XF86Search>", spawn "xdg-open https://duckduckgo.com")
    ]

myLayoutHook = avoidStruts $ layoutHook myConfig

myManageHook = composeAll
    [ manageDocks
    , className =? "Xmessage" --> doFloat
    ]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ myConfig
        { manageHook = myManageHook <+> manageHook myConfig
        , layoutHook = myLayoutHook
        , startupHook = setWMName "LG3D"
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "cyan" ""
            }
        , workspaces = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=" ]
        }
