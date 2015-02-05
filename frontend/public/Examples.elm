import Graphics.Element (..)
import List
import List ((::))
import Markdown
import Signal
import Text
import Website.Skeleton (skeleton)
import Website.ColorScheme (accent4)
import Website.Tiles as Tile
import Website.Widgets (headerFaces)
import Window


port title : String
port title = "代码样例"


main : Signal.Signal Element
main =
  Signal.map (skeleton "代码样例" body) Window.dimensions


body outer =
  let b = flow down <| List.intersperse (spacer 20 20) content
  in
    container outer (heightOf b) middle b

content =
  let w = 600
      exs = [ ("Display",elements), ("React",reactive), ("Compute",functional) ]
  in
      width w words ::
      List.map (subsection w) exs ++
      [ width w intermediate
      , Tile.examples w intermediates
      , width w projects
      ]

words = Markdown.toElement """

# 代码样例

学习页面上列出的这些例子可以帮你快速的熟悉Elm编程语言，这些例子都可以*[在线编辑运行](/try)*：

 * [基础入门](#basics) &mdash; 展示语法和设计的简单例子；
 * [稍稍复杂](#intermediate) &mdash; 稍微复杂的例子；
 * [完整应用演示](#big-projects) &mdash; 用Elm编写的可运行的网站和游戏；

当看到不明白的语法时记得查阅[Elm语法参考][syntax]。
如果你不看例子光看[ELm基础知识](/Learn.elm)就能学会那更好。
熟悉了语法以后就可以去看看[公共库的文档](/Libraries.elm)，可以学到更多的东西。

  [syntax]: /learn/Syntax.elm "The Syntax of Elm"

<h2 id="basics">基础入门</h2>

"""

intermediate = Markdown.toElement """

<h2 id="intermediate">稍稍复杂</h2>

"""

projects = Markdown.toElement """

<h2 id="big-projects">完整应用演示</h2>

下列是用Elm编写的完整应用，都放在了Github上，可以Fork出来研究。

#### 网站

 * [elm-todomvc](https://github.com/evancz/elm-todomvc) &mdash;
   用Elm编写的[TodoMVC](http://todomvc.com/)；
 * [elm-lang.org](https://github.com/elm-lang/elm-lang.org) &mdash;
   此网站的前后台代码；
 * [package.elm-lang.org](https://github.com/elm-lang/package.elm-lang.org) &mdash;
   package子站的源代码；
 * [Reddit Time Machine](https://github.com/Dobiasd/RedditTimeMachine) &mdash;
   从Reddit上面拉取新鲜事， by Tobias Hermann；
 * [EAN/UPC-A Barcode Generator](https://github.com/Dobiasd/Barcode-Generator) &mdash;
   条形码实时生成, by Tobias Hermann；

#### 游戏

 * [俄罗斯方块](https://github.com/jcollard/elmtris) &mdash;
   by Joe Collard；
 * [打砖块](https://github.com/Dobiasd/Breakout#breakout--play-it) &mdash;
   by Tobias Hermann；
 * [Maze](https://github.com/Dobiasd/Maze#maze--play-it) &mdash;
   by Tobias Hermann；
 * [记忆消除](https://github.com/Dobiasd/Demoscene-Concentration) &mdash;
   by Tobias Hermann；
 * [Froggy](https://github.com/thSoft/froggy) &mdash; by Dénes Harmath

"""


intermediates =
    let ex = List.map Tile.intermediate
        gl = List.map Tile.webgl
    in
        [ ex [ "Mario", "Walk", "Pong", "Turtle" ]
        , ex [ "TextReverse", "Calculator", "Form", "Flickr" ]
        , ex [ "Clock", "Plot", "SlideShow", "PieChart" ]
        , gl [ "Triangle", "Cube", "Thwomp", "FirstPerson" ]
        , ex [ "Physics", "Stamps" ]
        ]

addFolder folder lst =
  let add (x,y) = (x, folder ++ y ++ ".elm")
      f (n,xs) = (n, List.map add xs)
  in  List.map f lst

elements = addFolder "Elements/"
  [ ("Words",
        [ ("Text", "HelloWorld")
        , ("Markdown", "Markdown")
        ])
  , ("Images",
        [ ("Images", "Image")
        , ("Fitted", "FittedImage")
        , ("Cropped", "CroppedImage")
        ])
  , ("Formatting",
        [ ("Size"    , "Size")
        , ("Opacity" , "Opacity")
        , ("Text"    , "Text")
        , ("Typeface", "Typeface")
        ])
  , ("Layout",
        [ ("Simple Flow", "FlowDown1a")
        , ("Flow Down"  , "FlowDown2")
        , ("Layers"     , "Layers")
        ])
  , ("Positioning",
        [ ("Containers", "Position")
        , ("Spacers"   , "Spacer")
        ])
  , ("2D Shapes", [ ("Lines"     , "Lines")
                  , ("Shapes"    , "Shapes")
                  , ("Elements"  , "ToForm")
                  , ("Transforms", "Transforms")
                  ])
  , ("2D Fills", [ ("Color"    , "Color")
                 , ("Gradient", "LinearGradient")
                 , ("Radial Gradient", "RadialGradient")
                 , ("Texture"  , "Texture")
                 ])
  ]


functional = addFolder "Functional/"
  [ ("Recursion",
      [ ("Factorial"  , "Factorial")
      , ("List Length", "Length")
      , ("Zip"        , "Zip")
      , ("Quick Sort" , "QuickSort")
      ])
  , ("Functions",
      [ ("Functions"  , "Anonymous")
      , ("Application", "Application")
      , ("Composition", "Composition")
      , ("Infix Ops"  , "Infix")
      ])
  , ("Higher-Order",
      [ ("Map"    , "Map")
      , ("Fold"   , "Sum")
      , ("Filter" , "Filter")
      ])
  , ("Union Types",
      [ ("Maybe", "Maybe")
      , ("Boolean Expressions", "BooleanExpressions")
      , ("Tree", "Tree")
      ])
  , ("Libraries",
        [ ("Dict", "Dict")
        , ("Set", "Set")
        ])
  ]

reactive = addFolder "Reactive/"
  [ ("Mouse",  [ ("Position", "Position")
               , ("Presses"    , "IsDown")
               , ("Clicks"    , "CountClicks")
               , ("Yogi", "ResizeYogi")
               , ("Track", "Transforms")
               ])
  ,("Keyboard",[ ("Arrows"     , "Arrows")
               , ("wasd"       , "Wasd")
               , ("Keys Down"  , "KeysDown")
               , ("Key Presses", "CharPressed")
               ])
  , ("Touch",  [ ("Raw", "Touches")
               , ("Touches", "Touch")
               , ("Taps", "Taps")
               , ("Draw", "Draw")
               ])
  , ("Window", [ ("Size", "ResizePaint")
               , ("Centering", "Centering")
               ])
  , ("Time",   [ ("FPS"     , "Fps")
               , ("FPS when", "FpsWhen")
               , ("Every"   , "Every")
               ])
  , ("Input",  [ ("Text", "TextField")
               , ("Password"  , "Password")
               , ("Checkbox", "CheckBox")
               , ("Drop Down", "DropDown")
               ])
--  , ("Random", [ ("Randomize", "Randomize") ])
--  , ("Http",   [ ("Zip Codes", "ZipCodes") ])
  , ("Filters",[ ("Sample", "SampleOn")
               , ("Numbers Only", "KeepIf")
               ])
  , ("Ports",  [ ("Logging","Log")
               , ("Set Title","Title")
               , ("Redirect","Redirect")
               ])
  ]

example (name, loc) = Text.link ("/edit/examples/" ++ loc) (Text.fromString name)
toLinks (title, links) =
  flow right
   [ width 150 (Text.plainText <| "    " ++ title)
   , Text.leftAligned << Text.join (Text.fromString ", ") <| List.map example links
   ]

subsection w (name,info) =
  flow down << List.intersperse (spacer w 6) << List.map (width w) <|
    (tag name << Text.leftAligned << Text.typeface headerFaces << Text.bold <| Text.fromString name) ::
    spacer 0 0 ::
    List.map toLinks info ++ [spacer w 12]
