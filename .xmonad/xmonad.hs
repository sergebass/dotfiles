import XMonad
import XMonad.Actions.CopyWindow (copy)
import XMonad.Actions.CycleWS
import XMonad.Actions.DynamicWorkspaces
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP, additionalMouseBindings)
import XMonad.Util.Run(spawnPipe, hPutStrLn)
import qualified Data.Map as M
import qualified XMonad.StackSet as W

superMask = mod4Mask -- Use Super instead of Alt
altMask = mod1Mask

-- mouse buttons with their respective numbers
mouseLeftClick   = 1
mouseMiddleClick = 2
mouseRightClick  = 3
mouseWheelUp     = 4
mouseWheelDown   = 5
mouseWheelLeft   = 6
mouseWheelRight  = 7
mouseExtraButton1  = 8
mouseExtraButton2  = 9

myConfig = desktopConfig
    { modMask = superMask
    -- to change default terminal emulator, run:
    -- sudo update-alternatives --config x-terminal-emulator
    , terminal = "x-terminal-emulator"
    , borderWidth = 2
    , focusedBorderColor = "#FFB000" -- Orange-ish color
    , normalBorderColor = "#404040"
    }
     `additionalMouseBindings`
    [ ((superMask, mouseWheelUp), const $ spawn "sp-increase-audio-volume")
    , ((superMask, mouseWheelDown), const $ spawn "sp-decrease-audio-volume")
    , ((superMask, mouseMiddleClick), const $ spawn "sp-toggle-audio-mute")
    , ((superMask .|. altMask, mouseWheelUp), const $ spawn "pactl set-source-volume @DEFAULT_SOURCE@ +5%")
    , ((superMask .|. altMask, mouseWheelDown), const $ spawn "pactl set-source-volume @DEFAULT_SOURCE@ -5%")
    , ((superMask .|. altMask, mouseMiddleClick), const $ spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    , ((0, mouseExtraButton1), const $ spawn "sp-audio-volume-control")
    , ((0, mouseExtraButton2), const $ spawn "x-terminal-emulator -e ncmpcpp")
    ]
     `additionalKeys`
    [ ((superMask, xK_BackSpace), toggleWS)
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
    -- a shortcut to invoke xkill, to get rid of stuck GUI apps
    , ((superMask .|. altMask, xK_Delete), spawn "xkill")
    -- alternative shortcuts to launch terminal emulators in case the stock one does not work
    , ((superMask .|. controlMask, xK_Return), spawn "x-terminal-emulator")
    , ((superMask .|. controlMask .|. shiftMask, xK_Return), spawn "urxvt")
    , ((superMask .|. controlMask .|. shiftMask .|. altMask, xK_Return), spawn "xterm")
    -- several ways of session locking
    , ((superMask, xK_z), spawn "i3lock --ignore-empty-password --show-failed-attempts --tiling --color=002020 --image ~/background.png")
    , ((superMask .|. altMask, xK_z), spawn "xdg-screensaver lock") -- don't forget to run light-locker in background!
    , ((superMask .|. shiftMask, xK_z), spawn "xset dpms force off; slock")
    , ((superMask .|. controlMask, xK_z), spawn "xscreensaver-command -lock")
    -- alternative launchers
    , ((superMask, xK_Menu), spawn "exo-open /usr/share/applications")
    , ((superMask .|. altMask, xK_p), spawn "exo-open /usr/share/applications")
    -- system monitor
    , ((superMask, xK_Escape), spawn "x-terminal-emulator -e htop")
    -- take a screenshot of entire display
    , ((superMask, xK_Print), spawn "scrot screenshot--%Y-%m-%d-%H-%M-%S.png")
    , ((superMask .|. controlMask, xK_p), spawn "scrot screenshot--%Y-%m-%d-%H-%M-%S.png")
    -- take a screenshot of focused window
    , ((superMask .|. shiftMask, xK_Print), spawn "scrot -u screenshot--%Y-%m-%d-%H-%M-%S--window.png")
    , ((superMask .|. controlMask .|. shiftMask, xK_p), spawn "scrot -u screenshot--%Y-%m-%d-%H-%M-%S--window.png")
    -- various calculators
    , ((superMask, xK_equal), spawn "x-terminal-emulator -e ghci")  -- Haskell REPL doubles as a calculator quite well ;)
    , ((superMask, xK_KP_Enter), spawn "gnome-calculator")
    -- web browser
    , ((superMask, xK_slash), spawn "xdg-open https://duckduckgo.com")
    -- random background image selection
    , ((superMask .|. shiftMask, xK_minus), spawn "feh --bg-max --randomize --recursive ~/backgrounds/")
    -- keyboard layout switching
    , ((superMask, xK_F12), spawn "setxkbmap -layout \"us,ru,ua,us(intl)\" -option grp:shift_caps_toggle -option grp_led:scroll -option caps:escape")
    -- screen backlight brightness
    , ((superMask .|. controlMask, xK_bracketleft), spawn "xbacklight -dec 10")
    , ((superMask .|. controlMask, xK_bracketright), spawn "xbacklight -inc 10")
    , ((superMask .|. controlMask, xK_backslash), spawn "xbacklight -set 100")
    , ((superMask .|. controlMask, xK_1), spawn "set-laptop-backlight-brightness 0.1")
    , ((superMask .|. controlMask, xK_2), spawn "set-laptop-backlight-brightness 0.2")
    , ((superMask .|. controlMask, xK_3), spawn "set-laptop-backlight-brightness 0.3")
    , ((superMask .|. controlMask, xK_4), spawn "set-laptop-backlight-brightness 0.4")
    , ((superMask .|. controlMask, xK_5), spawn "set-laptop-backlight-brightness 0.5")
    , ((superMask .|. controlMask, xK_6), spawn "set-laptop-backlight-brightness 0.6")
    , ((superMask .|. controlMask, xK_7), spawn "set-laptop-backlight-brightness 0.7")
    , ((superMask .|. controlMask, xK_8), spawn "set-laptop-backlight-brightness 0.8")
    , ((superMask .|. controlMask, xK_9), spawn "set-laptop-backlight-brightness 0.9")
    , ((superMask .|. controlMask, xK_0), spawn "set-laptop-backlight-brightness 1.0")
    -- audio controls
    , ((0, 0x1008FF11), spawn "sp-decrease-audio-volume")
    , ((0, 0x1008FF13), spawn "sp-increase-audio-volume")
    , ((0, 0x1008FF12), spawn "sp-toggle-audio-mute")
    , ((superMask, xK_grave), spawn "sp-audio-volume-control")
    , ((superMask, xK_bracketleft), spawn "sp-decrease-audio-volume")
    , ((superMask, xK_bracketright), spawn "sp-increase-audio-volume")
    , ((superMask, xK_backslash), spawn "sp-toggle-audio-mute")
    , ((superMask .|. altMask, xK_bracketleft), spawn "pactl set-source-volume @DEFAULT_SOURCE@ -5%")
    , ((superMask .|. altMask, xK_bracketright), spawn "pactl set-source-volume @DEFAULT_SOURCE@ +5%")
    , ((superMask .|. altMask, xK_backslash), spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    , ((superMask .|. altMask, xK_1), spawn "pactl set-sink-volume @DEFAULT_SINK@ 10%")
    , ((superMask .|. altMask, xK_2), spawn "pactl set-sink-volume @DEFAULT_SINK@ 20%")
    , ((superMask .|. altMask, xK_3), spawn "pactl set-sink-volume @DEFAULT_SINK@ 30%")
    , ((superMask .|. altMask, xK_4), spawn "pactl set-sink-volume @DEFAULT_SINK@ 40%")
    , ((superMask .|. altMask, xK_5), spawn "pactl set-sink-volume @DEFAULT_SINK@ 50%")
    , ((superMask .|. altMask, xK_6), spawn "pactl set-sink-volume @DEFAULT_SINK@ 60%")
    , ((superMask .|. altMask, xK_7), spawn "pactl set-sink-volume @DEFAULT_SINK@ 70%")
    , ((superMask .|. altMask, xK_8), spawn "pactl set-sink-volume @DEFAULT_SINK@ 80%")
    , ((superMask .|. altMask, xK_9), spawn "pactl set-sink-volume @DEFAULT_SINK@ 90%")
    , ((superMask .|. altMask, xK_0), spawn "pactl set-sink-volume @DEFAULT_SINK@ 100%")
    , ((superMask .|. altMask, xK_Down), spawn "sp-decrease-audio-volume")
    , ((superMask .|. altMask, xK_Up), spawn "sp-increase-audio-volume")
    , ((superMask .|. altMask, xK_Home), spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    , ((superMask .|. altMask, xK_End), spawn "sp-toggle-audio-mute")
    -- song control
    , ((superMask .|. shiftMask, xK_grave), spawn "x-terminal-emulator -e ncmpcpp")
    , ((superMask .|. shiftMask, xK_bracketleft), spawn "mpc prev")
    , ((superMask .|. shiftMask, xK_bracketright), spawn "mpc next")
    , ((superMask .|. shiftMask, xK_backslash), spawn "mpc toggle")
    , ((superMask .|. altMask, xK_Left), spawn "mpc prev")
    , ((superMask .|. altMask, xK_Right), spawn "mpc next")
    ]
     `additionalKeysP` -- direct keys without prefix
    [ --audio controls
      ("<XF86AudioRaiseVolume>", spawn "sp-increase-audio-volume")
    , ("<XF86AudioLowerVolume>", spawn "sp-decrease-audio-volume")
    , ("<XF86AudioMute>", spawn "sp-toggle-audio-mute")
    , ("<XF86AudioMicMute>", spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    -- song control
    , ("<XF86AudioPlay>", spawn "mpc toggle")
    , ("<XF86AudioNext>", spawn "mpc next")
    , ("<XF86AudioPrev>", spawn "mpc prev")
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
