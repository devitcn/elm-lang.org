import Color
import Graphics.Element (..)
import Markdown
import Signal (Signal, (<~))
import Text
import Website.Widgets (bigLogo, installButtons, button)
import Website.Skeleton (skeleton)
import Website.BigTiles as Tile
import Website.ColorScheme as C
import Window

port title : String
port title = "Elm 编程语言 - functional web programming"

main = skeleton "" content <~ Window.dimensions

tagLine =
    Text.leftAligned <|
        Text.fromString "一种用于编写交互式应用程序的，" ++
        Text.link "/learn/What-is-FRP.elm" (Text.fromString "函数式、反应式") ++
        Text.fromString "编程语言。"

content outer =
    let inner = 600
        half = inner // 2
        center elem =
            container outer (heightOf elem) middle elem
        centerText msg =
            let msg' = width inner msg
            in  center msg'
    in
    color Color.white (flow down
    [ spacer outer 20
    , container outer 100 middle bigLogo
    , container outer 40 middle tagLine
    , center (installButtons 440)
    , spacer outer 20
    ]) `above` flow down
    [ color C.mediumGrey (spacer outer 1)
    , spacer outer 30
    , center threeKeywords
    , spacer outer 60
    , centerText exampleText
    , container outer 500 middle <| exampleBlock 860
    , center (button outer 260 "/Examples.elm" "更多的例子")
    , spacer outer 60
    , width outer debuggerTitle
    , centerText debuggerText
    , center debuggerBlock
    , center <| flow right
        [ button 220 180 "/try" "Edit"
        , button 220 180 "http://debug.elm-lang.org/try" "Debug"
        ]
    ]

threeKeywords =
    flow right
    [ width 260 functional
    , spacer 40 10
    , width 260 reactive
    , spacer 40 10
    , width 260 compatible
    ]

functional = Markdown.toElement """
<div style="font-family: futura, 'century gothic', 'twentieth century', calibri, verdana, helvetica, arial; text-align: center; font-size: 2em;">函数式</div>

具备不变性和类型推断的特点，可以让你更快的写出短小精悍而又易维护的代码。而且，Elm 还[容易学习](/Learn.elm)。

"""

reactive = Markdown.toElement """
<div style="font-family: futura, 'century gothic', 'twentieth century', calibri, verdana, helvetica, arial; text-align: center; font-size: 2em;">反应式</div>

Elm 基于[函数式、反应式编程思想](/learn/What-is-FRP.elm)。可以很容易的创建出方便交互的应用，而且没有凌乱的回调函数和纠结的状态机制。
"""

compatible = Markdown.toElement """
<div style="font-family: futura, 'century gothic', 'twentieth century', calibri, verdana, helvetica, arial; text-align: center; font-size: 2em;">兼容性</div>

Elm 会编译成HTML、CSS、JavaScript。在Elm中也能嵌入 [HTML][html] 和
[JS][ports]，所以将部分功能用Elm来编写是比较容易的。

[html]: /blog/Blazing-Fast-Html.elm
[ports]: /learn/Ports.elm

"""

exampleText = Markdown.toElement """

<div style="font-family: futura, 'century gothic', 'twentieth century', calibri, verdana, helvetica, arial; text-align: center; font-size: 3em;">例子</div>

Elm 非常适合用来编写[2D](/blog/Pong.elm)和[3D](https://github.com/johnpmayer/elm-webgl)游戏、
[图表](https://github.com/seliopou/elm-d3)、小部件、和[网站](/blog/Blazing-Fast-Html.elm)。
除下面列出的这些精彩例子外，还有很多的简单易懂、可直接修改的[教程示例](/Examples.elm)来帮助你学习 Elm 编程语言。

"""

exampleBlock w =
    Tile.examples w
    [ [ ("Home/Mario", "/edit/examples/Intermediate/Mario.elm", Nothing)
      , ("Home/Elmtris", "http://people.cs.umass.edu/~jcollard/elmtris/", Just "https://github.com/jcollard/elmtris")
      , ("Home/Vessel", "https://slawrence.github.io/vessel", Just "https://github.com/slawrence/vessel")
      , ("Home/FirstPerson", "https://evancz.github.io/first-person-elm", Just "https://github.com/evancz/first-person-elm")
      ]
    , [ ("Home/Todo", "https://evancz.github.io/elm-todomvc", Just "https://github.com/evancz/elm-todomvc")
      , ("Home/DreamWriter", "http://dreamwriter.io", Just "https://github.com/rtfeldman/dreamwriter")
      , ("Home/Catalog", "http://package.elm-lang.org/packages/elm-lang/core/latest", Just "https://github.com/elm-lang/package.elm-lang.org")
      , ("Home/Fractal", "http://gideon.smdng.nl/2014/04/fractals-for-fun-and-profit/", Nothing)
      ]
    ]

debuggerTitle = Markdown.toElement """

<div style="font-family: futura, 'century gothic', 'twentieth century', calibri, verdana, helvetica, arial; text-align: center; font-size: 3em;">时间线调试器</div>

"""

debuggerText = Markdown.toElement """

Elm 提供开发工具：[Elm Reactor][reactor]，其中的[时间线调试器][debug]使得调试和侦测变得容易。
而且还支持[热部署](/blog/Interactive-Programming.elm)，可以直接修改运行中的代码。
还能够和你喜欢的代码编辑器一起工作。

[debug]: http://debug.elm-lang.org
[reactor]: /blog/Introducing-Elm-Reactor.elm

"""

debuggerBlock =
    Tile.example (860,260) ("Home/Debugger", "/blog/Introducing-Elm-Reactor.elm", Nothing)
