import Graphics.Element exposing (..)
import Markdown
import Time exposing (..)


port title : Signal String
port title =
  Signal.map toString (every second)


main : Element
main = Markdown.toElement """

# Setting titles with ports

This example uses [ports](http://elm-lang.org/learn/Ports.elm)
to set the pages title.
<a href="/examples/Reactive/Title.elm" target="_top">
Switch to full screen</a> to see the title changing.

See [the full list of built-in port
handlers](/learn/Syntax.elm#javascript-ffi) for more information.

"""