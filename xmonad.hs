import qualified Data.Map                     as M
import           Data.Monoid                  (All (..), mempty, (<>),appEndo)
import           Graphics.X11.Types           (Button, ButtonMask, KeyMask,
                                               KeySym, Window, mod4Mask)
import           Graphics.X11.Xlib            (button1, button2, button3)
import           Graphics.X11.Xlib.Extras     (Event)
import           Graphics.X11.Xlib.Types      (Dimension)
import           System.Exit                  (exitSuccess)
import           System.IO                    (Handle, hPutStrLn)
import           XMonad.Core                  (Layout, ManageHook, WorkspaceId,
                                               X, XConfig (..), io,
                                               spawn, runQuery)
import XMonad.Hooks.ManageHelpers(doFullFloat)
import           XMonad.Hooks.DynamicLog      (PP (..), dynamicLogWithPP,
                                               shorten, wrap, xmobarColor)
import           XMonad.Hooks.EwmhDesktops    (ewmh)
import           XMonad.Layout.NoBorders    (smartBorders)
import           XMonad.Hooks.ManageDocks     (avoidStruts, manageDocks)
import           XMonad.Hooks.SetWMName       (setWMName)
import           XMonad.Layout                (ChangeLayout (..), Full (..),
                                               Mirror (..), Resize (..),
                                               Tall (..), (|||))
import           XMonad.Main                  (xmonad)
import           XMonad.ManageHook            (className, composeAll, doFloat,
                                               (-->), (<+>), (=?))
import           XMonad.Operations            (focus, kill, mouseMoveWindow,
                                               mouseResizeWindow, sendMessage,
                                               windows, withFocused)
import qualified XMonad.StackSet              as W
import           XMonad.Util.EZConfig         (mkKeymap,additionalKeysP)
import           XMonad.Util.Run              (spawnPipe)
import           XMonad.Util.WorkspaceCompare (getSortByIndex)
import XMonad.Util.Scratchpad(scratchpadSpawnActionTerminal,scratchpadManageHook)

myBorderWidth :: Dimension
myBorderWidth = 1

myWorkspaces :: [WorkspaceId]
myWorkspaces = map show [1 .. 9 :: Int]

-- avoidStruts wegen xmobar
myLayout = smartBorders ( avoidStruts ( tiled ||| Mirror tiled ||| Full ) )
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "urxvt"

myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor  = "gray"
myFocusedBorderColor = "red"

myLogHook :: X ()
myLogHook = return ()

myStartupHook :: X ()
myStartupHook = return ()

-- manageDocks wegen xmobar
myManageHook :: ManageHook
{-
myManageHook = composeAll
                [ className =? "MPlayer"        --> doFloat
                , className =? "Gimp"           --> doFloat ]
-}
myManageHook = mempty

myHandleEventHook :: Event -> X All
myHandleEventHook _ = return (All True)

myMouseBindings :: XConfig Layout -> M.Map (ButtonMask, Button) (Window -> X ())
myMouseBindings (XConfig {modMask = mm}) = M.fromList
  [ ((mm, button1), \w -> focus w >> mouseMoveWindow w
                                          >> windows W.shiftMaster)
  , ((mm, button2), windows . (W.shiftMaster .) . W.focusWindow)
  , ((mm, button3), \w -> focus w >> mouseResizeWindow w
                                         >> windows W.shiftMaster)
  ]

fullFloat :: Window -> X ()
fullFloat f = windows =<< appEndo `fmap` runQuery doFullFloat f

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf = mkKeymap conf $
  [ ("M-<Return>",                                               spawn (terminal conf))
  , ("M-p",                                                      spawn "dmenu_run")
  , ("M-S-c",                                                    kill)
  , ("M-<Space>",                                                sendMessage NextLayout)
  , ("M-j",                                                      windows W.focusDown)
  , ("M-k",                                                      windows W.focusUp)
  , ("M-S-j",                                                    windows W.swapDown)
  , ("M-S-k",                                                    windows W.swapUp)
  , ("M-h",                                                      sendMessage Shrink)
  , ("M-l",                                                      sendMessage Expand)
  , ("M-f",                                                      withFocused fullFloat)
  , ("M-t",                                                      withFocused $ windows . W.sink)
  , ("M-S-q",                                                    io exitSuccess)
  , ("M-S-r",                                                    spawn "xmonad --recompile && xmonad --restart")
  ] ++
  [ ("M-" ++ k,windows ( W.greedyView k )) | k <- workspaces conf ] ++
  [ ("M-S-" ++ k,windows ( W.shift k )) | k <- workspaces conf ]

defaultPP :: Handle -> PP
defaultPP statusHandle =
  PP { ppCurrent         = xmobarColor "yellow" ""
     , ppVisible         = wrap "(" ")"
     , ppHidden          = xmobarColor "green" "" . (\ws -> if ws == "NSP" then "" else ws)
     , ppHiddenNoWindows = id
     , ppTitleSanitize   = id
     , ppUrgent          = xmobarColor "red" "yellow"
     , ppSep             = " : "
     , ppWsSep           = " | "
     , ppTitle           = xmobarColor "green"  "" . shorten 200
     , ppLayout          = const ""
     , ppOrder           = id
     , ppOutput          = hPutStrLn statusHandle
     , ppSort            = getSortByIndex
     , ppExtras          = []
     }

myConfig = XConfig
  { borderWidth        = myBorderWidth
  , workspaces         = myWorkspaces
  , layoutHook         = myLayout
  , terminal           = myTerminal
  , normalBorderColor  = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , modMask            = myModMask
  , keys               = myKeys
  , logHook            = myLogHook
  , startupHook        = myStartupHook
  , mouseBindings      = myMouseBindings
  , manageHook         = myManageHook
  , handleEventHook    = myHandleEventHook
  , focusFollowsMouse  = True
  , clickJustFocuses   = True
  }

wrapXmobar :: Handle -> XConfig l -> XConfig l
wrapXmobar h c = c
  { manageHook = manageDocks <+> manageHook c
  , logHook = dynamicLogWithPP ( defaultPP h )
  }

fixJava :: XConfig l -> XConfig l
fixJava c = c
  { startupHook = startupHook c <> setWMName "LG3D"
  }

addScratchpad :: XConfig l -> XConfig l
addScratchpad c = c
  { manageHook = manageHook c <+> scratchpadManageHook (W.RationalRect 0 0 1 0.1) }
  `additionalKeysP` [("M-`",scratchpadSpawnActionTerminal (terminal c))]

main :: IO ()
main = do
  h <- spawnPipe "xmobar"
  xmonad ( addScratchpad . fixJava . ewmh . wrapXmobar h $ myConfig )
