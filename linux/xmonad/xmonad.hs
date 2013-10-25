import XMonad
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders

startup :: X ()
startup = do
  spawn "~/.xmonad/hooks/startup"

myLayout = noBorders Full ||| tiled
  where
    tiled = Tall 1 (3/100) (3/5)

main = do
  xmonad $ defaultConfig {
    startupHook = startup
    , layoutHook = myLayout
    , modMask = mod4Mask
    }
