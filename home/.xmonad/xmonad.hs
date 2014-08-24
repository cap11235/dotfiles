import XMonad.Hooks.SetWMName
import XMonad.Layout.Tabbed
import XMonad
import Data.Monoid
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import System.Exit
import XMonad.Hooks.EwmhDesktops
import Graphics.X11.ExtraTypes.XF86

myLayout = tiled ||| Mirror tiled ||| Full ||| simpleTabbed
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

main = do
  xmproc <- spawnPipe "xmobar ~/.xmobarrc"
  xmonad $ ewmh $ defaultConfig
    { manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts myLayout
    , logHook = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle = xmobarColor "green" "" . shorten 50
      }
    , terminal           = "termite"
    , modMask            = mod4Mask
    , startupHook = setWMName "LG3D"
    } `additionalKeys`
      [ ((mod4Mask, xK_a), spawn "termite")
      , ((mod4Mask, xK_Return), spawn "termite")
      , ((mod4Mask, xK_b), sendMessage ToggleStruts)
      , ((mod4Mask, xK_m), spawn "passmenu")
      , ((0 , xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 1 +3%")
      , ((0 , xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 1 -- -3%")
      , ((0 , xF86XK_AudioMute), spawn "pactl set-sink-mute 1 toggle")
      ]
