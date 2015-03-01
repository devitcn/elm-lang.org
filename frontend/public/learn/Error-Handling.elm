import Graphics.Element (..)
import Markdown
import Signal (Signal, (<~))
import Website.Skeleton (skeleton)
import Window

port title : String
port title = "处理错误"


main : Signal Element
main =
  skeleton "开始学习" (\w -> width (min 600 w) content) <~ Window.dimensions


content : Element
content = Markdown.toElement """

# 处理错误

The [`Maybe`][maybe] library is one of the easiest ways to do error handling
in Elm. This page goes through some examples, building up to some strategies
that make error handling nice as things get more complicated.

[maybe]: http://package.elm-lang.org/packages/elm-lang/core/latest/Maybe

## A Function that may Fail

Say we would like to do

"""
