import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig(additionalKeys)
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
        , ((0, 0x1008FF11), spawn "amixer set Master 5%-")
        , ((0, 0x1008FF13), spawn "amixer set Master 5%+")
        , ((0, 0x1008FF12), spawn "amixer -D pulse set Master toggle")
        ]

myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

toggleStrutsKey XConfig { XMonad.modMask = mod4Mask } = (mod4Mask, xK_b)

main = xmonad =<< statusBar "xmobar" myPP toggleStrutsKey myConfig
