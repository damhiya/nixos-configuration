module Main where

import System.Posix.Types
import System.Posix.IO
import System.IO
import System.Exit
import System.Directory
import System.Environment

import Data.String
import qualified Data.Map                 as M

import Control.Monad

-- xmonad
import XMonad
import qualified XMonad.StackSet as W

-- xmonad-contrib
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders

-- X11
import Graphics.X11.ExtraTypes.XF86

myNormalBorderColor   = "#FFFFFF"
myFocusedBorderColor  = "#4646FA"
myTerminal            = "termite -e fish -d \"$(xcwd)\""
myLayoutHook = lessBorders OnlyScreenFloat (avoidStruts tiled ||| noBorders Full)
  where
    tiled = space $ Tall nmaster delta ratio
    space = spacingRaw False (Border 10 10 10 10) True (Border 20 20 20 20) True
    nmaster = 1
    delta   = 1/32
    ratio   = 1/2

myWorkspaces          = ["α", "β" ,"γ", "δ", "ε", "ζ", "η", "θ", "ι"] 
myModMask             = mod1Mask

myBorderWidth         = 10

myStartupHook :: X ()
myStartupHook = do
  spawn . unlines $
    [ "MONITORS=\"$(xrandr | awk \'/\\<connected\\>/{print $1}\')\""
    , "if echo $MONITORS | grep -wq \'DP-2\' ; then"
    , "  xrandr --output \'DP-4\' --primary --output \'DP-2\' --right-of \'DP-4\'"
    , "else"
    , "  xrandr --output \'DP-4\' --primary"
    , "fi"
    , "systemctl --user restart polybar.service"
    , "feh --bg-fill ~/Pictures/wallpaper"
    ]
  spawn "kime"
  spawn "systemctl --user restart picom.service"
  pure ()

myFocusFollowsMouse   = True
myClickJustFocuses    = False

restartXMonad :: X ()
restartXMonad = spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi"

main :: IO ()
main = do
  let
    { myKeys conf@(XConfig {modMask = modMask}) = M.fromList $
        [ ((modMask .|. shiftMask, xK_Return), spawn $ terminal conf)
        , ((modMask,               xK_p     ), spawn "rofi -font \"monospace 24\" -show run")
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

        , ((modMask .|. shiftMask, xK_q     ), io exitSuccess)
        , ((modMask              , xK_q     ), restartXMonad)

        , ((0                    , xF86XK_AudioLowerVolume), spawn "pamixer -d 3")
        , ((0                    , xF86XK_AudioRaiseVolume), spawn "pamixer -i 3")
        , ((0                    , xF86XK_AudioMute       ), spawn "pamixer -t")

        , ((0                    , xF86XK_MonBrightnessUp   ), spawn "light -A 10")
        , ((0                    , xF86XK_MonBrightnessDown ), spawn "light -U 10")

        , ((modMask              , xK_Print ), spawn "import -window root ~/Pictures/Screenshots/screenshot.png")
        ]
        ++ [((modMask              , k), windows (W.greedyView i))
            | (i,k) <- zip (workspaces conf) [xK_1 .. xK_9]]
        ++ [((modMask .|. shiftMask, k), windows $ W.shift      i) | (i,k) <- zip (workspaces conf) [xK_1 .. xK_9]]

        ++
        [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
            | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
            , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    ; myConfig = ewmhFullscreen . ewmh . docks $ def
        { normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , terminal           = myTerminal
        , layoutHook         = myLayoutHook
    --     , manageHook         = myManageHook
    --     , handleEventHook    = myHandleEventHook
        , workspaces         = myWorkspaces
        , modMask            = myModMask
        , keys               = myKeys
    --     , mouseBindings      = myMouseBindings
        , borderWidth        = myBorderWidth
    --    , logHook            = myLogHook
        , startupHook        = myStartupHook
        , focusFollowsMouse  = myFocusFollowsMouse
        , clickJustFocuses   = myClickJustFocuses
    --     , rootMask           = myRootMask
    --     , handleExtraArgs    = myHandleExtraArgs
        }
    }

  xmonad myConfig
