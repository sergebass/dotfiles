import XMonad
import XMonad.Actions.CopyWindow (copy)
import XMonad.Actions.CycleWS
import XMonad.Actions.DynamicWorkspaces
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import XMonad.Util.Run(spawnPipe, hPutStrLn)
import qualified Data.Map as M
import qualified XMonad.StackSet as W

superMask = mod4Mask -- Use Super instead of Alt
altMask = mod1Mask

myConfig = desktopConfig
    { modMask = superMask
    , terminal = "x-terminal-emulator"
    , borderWidth = 2
    , focusedBorderColor = "#FFB000" -- Orange-ish color
    , normalBorderColor = "#404040"
    }
     `additionalKeys`
    [ ((superMask, xK_minus), toggleWS)
    , ((superMask, xK_0), addWorkspace "0")
    , ((superMask, xK_s), selectWorkspace def)
    , ((superMask, xK_Left), prevWS)
    , ((superMask, xK_Right), nextWS)
    , ((superMask .|. shiftMask, xK_Left), shiftToPrev >> prevWS)
    , ((superMask .|. shiftMask, xK_Right), shiftToNext >> nextWS)
    , ((superMask .|. shiftMask, xK_n), renameWorkspace def)
    , ((superMask .|. shiftMask, xK_m), withWorkspace def (windows . W.shift))
    , ((superMask .|. shiftMask, xK_equal), withWorkspace def (windows . copy))
    , ((superMask .|. shiftMask, xK_d), removeWorkspace)
    -- several ways of session locking
    , ((superMask, xK_z), spawn "dm-tool lock") -- don't forget to run light-locker in background!
    , ((superMask .|. shiftMask, xK_z), spawn "xset dpms force off; slock")
    , ((superMask .|. altMask, xK_z), spawn "i3lock -c 000000")
    , ((superMask .|. controlMask, xK_z), spawn "xscreensaver-command -lock")
    -- alternative launchers
    , ((superMask, xK_Menu), spawn "gmrun")
    -- take a screenshot of entire display
    , ((superMask, xK_Print), spawn "scrot screenshot--%Y-%m-%d-%H-%M-%S.png")
    -- take a screenshot of focused window
    , ((superMask .|. shiftMask, xK_Print), spawn "scrot -u screenshot--%Y-%m-%d-%H-%M-%S--window.png")
    -- various calculators
    , ((superMask, xK_equal), spawn "urxvt -e bc -l")
    , ((superMask, xK_KP_Enter), spawn "gnome-calculator")
    -- web browser
    , ((superMask, xK_slash), spawn "xdg-open https://duckduckgo.com")
    -- keyboard layout switching
    , ((superMask, xK_F12), spawn "setxkbmap -layout \"us,ru,ua,us(intl)\" -option grp:shift_caps_toggle -option grp_led:scroll -option caps:escape")
    -- screen backlight brightness
    , ((superMask .|. controlMask, xK_bracketleft), spawn "xbacklight -dec 10")
    , ((superMask .|. controlMask, xK_bracketright), spawn "xbacklight -inc 10")
    , ((superMask .|. controlMask, xK_backslash), spawn "xbacklight -set 100")
    -- audio controls
    , ((superMask, xK_v), spawn "pavucontrol")
    , ((superMask, xK_bracketleft), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ((superMask, xK_bracketright), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ((superMask, xK_backslash), spawn "pactl set-sink-volume @DEFAULT_SINK@ 20%")
    , ((superMask, xK_Page_Up), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ((superMask, xK_Page_Down), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ((superMask, xK_Home), spawn "pactl set-sink-volume @DEFAULT_SINK@ 50%")
    , ((superMask, xK_End), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ((superMask .|. shiftMask, xK_Page_Up), spawn "amixer -D pulse sset Master unmute 5%+")
    , ((superMask .|. shiftMask, xK_Page_Down), spawn "amixer -D pulse sset Master unmute 5%-")
    , ((superMask .|. shiftMask, xK_Home), spawn "amixer -D pulse sset Master 50%")
    , ((superMask .|. shiftMask, xK_End), spawn "amixer -D pulse sset Master toggle")
    , ((0, 0x1008FF11), spawn "amixer -D pulse set Master 5%-")
    , ((0, 0x1008FF13), spawn "amixer -D pulse set Master 5%+")
    , ((0, 0x1008FF12), spawn "amixer -D pulse set Master toggle")
    ]
     `additionalKeysP`
    [ --audio controls
      ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ("<XF86AudioMicMute>", spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    -- screen backlight brightness
    , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10")
    , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10")
    -- miscellaneous stuff
    , ("<XF86Explorer>", spawn "thunar")
    , ("<XF86Calculator>", spawn "gnome-calculator")
    , ("<XF86Search>", spawn "xdg-open https://duckduckgo.com")
    ]

myLayoutHook = avoidStruts $ layoutHook myConfig

myManageHook = composeAll
    [ manageDocks
    , className =? "Java" --> doFloat -- for Eclipse splash screen etc.
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
        }
