
-- Focus on the display screen (i.e. click the right half of this window)
-- and start pressing keys!

import Graphics.Element exposing (..)
import Keyboard
import Set


display : Set.Set Int -> Element
display keyCodes =
  flow right
    [ show "You are holding down the following keys: "
    , show (Set.toList keyCodes)
    ]


main : Signal.Signal Element
main =
  Signal.map display Keyboard.keysDown