import Color (..)
import Graphics.Element (..)
import List
import List ((::))
import Markdown
import Mouse
import Signal
import Text
import Website.Skeleton (skeleton)
import Website.ColorScheme as C
import Window

port title : String
port title = "信号的概念解释?"


main : Signal Element
main =
  Signal.map2 (skeleton "开始学习")
      (Signal.map view (box examples1))
      Window.dimensions


view exs1 outer =
    let w = 800
        body =
          flow down
            [ viewIntro exs1 w
            , width w why
            ]
    in
        container outer (heightOf body) middle body


viewIntro exs w =
  let hw = w // 2 - 15 in
  flow down
    [ flow right
        [ width hw what1
        , spacer 30 10
        , flow down
            [ spacer hw 20
            , container hw (heightOf exs) middle exs
            , spacer hw 20
            , width hw what2
            ]
        ]
    ]


---- Text of the page: all written in Markdown ----

what1 = Markdown.toElement """

# 什么是信号?

*信号*是一个随着时间而变化的量。 它们构成了Elm程序交互的基础。

在右面蓝色框中可以看到真实的信号的例子，尝试让他们发生变化来理解其功用。

The first example is the position of the mouse. In Elm, the mouse position
is represented by a signal named `Mouse.position`. When the mouse moves, the
value of `Mouse.position` changes automatically ([see more][mouse]).

  [mouse]: /edit/examples/Reactive/Position.elm "mouse"

"""

what2 = Markdown.toElement """

The `Window.dimensions` signal works exactly the same way, automatically
changing whenever the window is resized ([see more][dimensions]).

  [dimensions]: /edit/examples/Reactive/ResizePaint.elm "dimensions"

These examples are just the basics of signals. More information on how to use
signals can be found in [this tutorial](/learn/Using-Signals.elm) and in
[the documentation](http://package.elm-lang.org/packages/elm-lang/core/latest/Signal).
There are also tons of other [interactive examples](/Examples.elm) that allow
you to play around with FRP in [Elm](/).

"""


why = Markdown.toElement """

## What is the big deal?

The core idea is relatively simple, but the implications are surprisingly far
reaching. Some of the coolest features in Elm&rsquo;s tooling are entirely
dependent on signals, like [hot-swapping][] and [time-travel debugging][reactor].
Signals also subtly guide you towards [great architecture][architecture], making
it easy to render [HTML super fast][html]. The best evidence is code though,
so take a look at [the examples](/Examples.elm)!

[hot-swapping]: /blog/Interactive-Programming.elm
[reactor]: /blog/Introducing-Elm-Reactor.elm
[html]: /blog/Blazing-Fast-Html.elm
[architecture]: /learn/Architecture.elm


"""


---- Putting together the examples and making them pretty ----

entry w1 w2 v1 v2 =
  container w1 40 middle v1 `beside` container w2 40 middle v2


example w1 w2 code =
  Signal.map (\info -> entry w1 w2 (Text.leftAligned (Text.monospace (Text.fromString code))) (Text.asText info))


examples1 =
  let title = Text.leftAligned << Text.bold << Text.fromString
      example' = example 200 140
  in
      [ Signal.constant (entry 200 140 (title "Source Code") (title "Value"))
      , example' "Mouse.position" Mouse.position
      , example' "Window.dimensions" Window.dimensions
      ]


box exs =
  let putInBox exs =
        let eBox  = color white <| flow down exs
        in  color C.accent1 <|
            container (widthOf eBox + 4) (heightOf eBox + 4) middle eBox
  in
      Signal.map putInBox <| List.foldr (Signal.map2 (::)) (Signal.constant []) exs

