{-# LANGUAGE QuasiQuotes #-}

module Main where

import System.Posix.Types
import System.Posix.IO
import System.IO
import System.Exit
import System.Directory
import System.Environment

import Data.String
import Data.Map qualified as M

import Control.Monad

import PyF

-- xmonad
import XMonad
import XMonad.StackSet qualified as W

-- xmonad-contrib
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders

-- X11
import Graphics.X11.ExtraTypes.XF86

-- actions
restartXMonad :: X ()
restartXMonad = spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi"

captureOutput :: String
captureOutput = "~/Pictures/Screenshots/screenshot.png"

captureWindow :: Window -> X ()
captureWindow w = spawn [fmt|import -border -screen -window {w} {captureOutput} && xclip -selection clipboard -t image/png -i {captureOutput}|]

captureRegion :: X ()
captureRegion = spawn [fmt|import {captureOutput} && xclip -selection clipboard -t image/png -i {captureOutput}|]

captureRoot :: X ()
captureRoot = spawn [fmt|import -window root {captureOutput} && xclip -selection clipboard -t image/png -i {captureOutput}|]

type LightConfig = (String, Int)

monitorBacklight :: LightConfig
monitorBacklight = ("sysfs/backlight/nvidia_0", 10)

keyboardBacklight :: LightConfig
keyboardBacklight = ("sysfs/leds/tpacpi::kbd_backlight", 50)

modifyLight :: LightConfig -> Bool -> X ()
modifyLight (dev, step) b = spawn [fmt|light -s {dev} -{inc} {step}|]
  where inc = if b then 'A' else 'U'

modifyAudio :: Bool -> X ()
modifyAudio b = spawn [fmt|pactl set-sink-volume @DEFAULT_SINK@ {sign}3%|]
  where sign = if b then '+' else '-'

toggleAudioMute :: X ()
toggleAudioMute = spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"

toggleAudioMicMute :: X ()
toggleAudioMicMute = spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle"

-- my config
myNormalBorderColor   = "#FFFFFF"
myFocusedBorderColor  = "#4646FA"
myTerminal            = "alacritty -o \"working_directory=\\\"$(xcwd)\\\"\""
myLayoutHook = lessBorders OnlyScreenFloat (avoidStruts tiled ||| noBorders Full)
  where
    tiled = space $ Tall nmaster delta ratio
    space = spacingRaw False (Border 10 10 10 10) True (Border 20 20 20 20) True
    nmaster = 1
    delta   = 1/32
    ratio   = 1/2

myWorkspaces          = ["α", "β" ,"γ", "δ", "ε", "ζ", "η", "θ", "ι", "κ"] 
myModMask             = mod4Mask

myKeys conf@(XConfig {modMask = modMask}) = M.fromList $
  [ ((modMask .|. shiftMask, xK_Return), spawn $ terminal conf)
  , ((modMask,               xK_p     ), spawn "rofi -font \"Iosevka 24\" -show drun")
  , ((modMask .|. shiftMask, xK_c     ), kill)

  -- , ((modMask,               xK_space ), sendMessage NextLayout)
  , ((modMask,               xK_Return), sendMessage NextLayout)
  , ((modMask .|. shiftMask, xK_space ), setLayout $ layoutHook conf)

  , ((modMask,               xK_Tab   ), windows W.focusDown)
  , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusUp  )
  , ((modMask,               xK_j     ), windows W.focusDown)
  , ((modMask,               xK_k     ), windows W.focusUp  )
  , ((modMask,               xK_m     ), windows W.focusMaster  )

  -- , ((modMask,               xK_Return), windows W.swapMaster)
  , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
  , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

  , ((modMask,               xK_h     ), sendMessage Shrink)
  , ((modMask,               xK_l     ), sendMessage Expand)

  , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

  , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
  , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

  , ((modMask .|. shiftMask, xK_q     ), spawn "killall kime" >> io exitSuccess)
  , ((modMask .|. shiftMask, xK_r     ), restartXMonad)

  , ((0                    , xF86XK_AudioRaiseVolume), modifyAudio True)
  , ((0                    , xF86XK_AudioLowerVolume), modifyAudio False)
  , ((0                    , xF86XK_AudioMute       ), toggleAudioMute)
  , ((0                    , xF86XK_AudioMicMute    ), toggleAudioMicMute)

  , ((0                    , xF86XK_MonBrightnessUp   ), modifyLight monitorBacklight True)
  , ((0                    , xF86XK_MonBrightnessDown ), modifyLight monitorBacklight False)
  , ((shiftMask            , xF86XK_MonBrightnessUp   ), modifyLight keyboardBacklight True)
  , ((shiftMask            , xF86XK_MonBrightnessDown ), modifyLight keyboardBacklight False)

  , ((0                    , xK_Print ), withFocused captureWindow)
  , ((controlMask          , xK_Print ), captureRegion)
  , ((shiftMask            , xK_Print ), captureRoot)
  ]
  ++ [ ((modMask              , k), windows (W.greedyView i))
     | (i,k) <- zip (workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
     ]
  ++ [ ((modMask .|. shiftMask, k), windows $ W.shift      i)
     | (i,k) <- zip (workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
     ]
  ++ [ ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
     | (key, sc) <- zip [xK_a, xK_s, xK_d] [0..]
     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
     ]

myBorderWidth         = 10

myStartupHook :: X ()
myStartupHook = do
  spawn . unlines $
    [ "xsetroot -cursor_name left_ptr"
    , "autorandr --change --skip-option crtc"
    , "systemctl --user restart polybar.service"
    , "feh --bg-fill ~/Pictures/wallpaper"
    ]
  spawn "kime"
  spawn "systemctl --user restart picom.service"
  pure ()

myFocusFollowsMouse   = True
myClickJustFocuses    = False

myConfig = ewmhFullscreen . ewmh . docks $ def
  { normalBorderColor  = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , terminal           = myTerminal
  , layoutHook         = myLayoutHook
  -- , manageHook         = myManageHook
  -- , handleEventHook    = myHandleEventHook
  , workspaces         = myWorkspaces
  , modMask            = myModMask
  , keys               = myKeys
  -- , mouseBindings      = myMouseBindings
  , borderWidth        = myBorderWidth
  -- , logHook            = myLogHook
  , startupHook        = myStartupHook
  , focusFollowsMouse  = myFocusFollowsMouse
  , clickJustFocuses   = myClickJustFocuses
  -- , clientMask         = myClientMask
  -- , rootMask           = myRootMask
  -- , handleExtraArgs    = myHandleExtraArgs
  -- , extensibleConf     = myExtensibleConf
  }

main :: IO ()
main = xmonad myConfig
