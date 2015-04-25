import Color exposing (..)
import Graphics.Element exposing (..)
import Markdown
import Mouse
import Text
import Website.Skeleton exposing (skeleton)
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

第一个例子是显示鼠标位置的程序。在Elm中，鼠标的位置用名为`Mouse.position`的信号变量来表示。
当鼠标位置发生变化时，`Mouse.position`的值会相应地自动改变（[详细资料][mouse]）。

  [mouse]: /edit/examples/Reactive/Position.elm "mouse"

"""

what2 = Markdown.toElement """

`Window.dimensions`信号和前面鼠标位置的例子一样，每当窗口尺寸发生变化时就会自动改变([详情][dimensions])。

  [dimensions]: /edit/examples/Reactive/ResizePaint.elm "dimensions"

这还是两个简单的实例。更详细的信息可以查看[这个教程](/learn/Using-Signals.elm)或者
[文档](http://package.elm-lang.org/packages/elm-lang/core/latest/Signal)。
还有更多的[实例](/Examples.elm)可供研究学习。

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
  Signal.map (\info -> entry w1 w2 (leftAligned (Text.monospace (Text.fromString code))) (show info))


examples1 =
  let title = leftAligned << Text.bold << Text.fromString
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

