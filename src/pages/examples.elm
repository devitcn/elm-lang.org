import Html exposing (..)
import Html.Attributes exposing (..)

import Center
import Skeleton



main =
  Skeleton.skeleton
    "examples"
    [ Center.markdown "600px" content
    , div [ Center.style "600px" , style ["padding" => "0 0.5em"]]
        [ view "HTML" html
        , view "Core Language" fundamentals
        , view "Effects" effects
        , view "Functional Thinking" core
        ]
    ]


content = """

# 例子

这些例子比较简单，帮助你快速入门Elm语言。
熟悉之后可以来看 [入门指南][guide]
和 [语法参考][syntax] 。

[guide]: https://guide.elm-lang.org/
[syntax]: /docs/syntax

"""



-- VIEW EXAMPLES


(=>) = (,)


view : String -> List Section -> Html msg
view title sections =
  div
    [ class "examples"
    , style ["width" => "300px", "display" => "inline-block", "vertical-align" => "top"]
    ]
    [ h3 [] [text title]
    , ul [] (List.map viewSection sections)
    ]


viewSection : Section -> Html msg
viewSection (title, examples) =
  li []
    [ text title
    , ul [] (List.map viewExample examples)
    ]


viewExample : (String, String) -> Html msg
viewExample (name, fileName) =
  let
    url =
      "/examples/" ++ fileName
  in
    li [] [ a [href url] [text name] ]



-- EXAMPLES


type alias Section = (String, List (String, String))


fundamentals : List Section
fundamentals =
  [ "Primitives" =>
      [ "math" => "math"
      , "strings" => "strings"
      , "calling functions" => "functions"
      , "defining functions" => "define-functions"
      ]
  , "Syntax" =>
      [ "if" => "if"
      , "let" => "let"
      , "case" => "case"
      , "lambda" => "lambda"
      , "pipes" => "pipes"
      , "types" => "types"
      ]
  ]


core : List Section
core =
  [ "Recursion" =>
      [ "list length" => "length"
      , "zip" => "zip"
      , "quick sort" => "quick-sort"
      , "merge sort" => "merge-sort"
      ]
  , "Union Types" =>
      [ "either" => "either"
      , "binary tree" => "binary-tree"
      , "boolean expressions" => "boolean-expressions"
      ]
  ]


html : List Section
html =
  [ "Basics" =>
      [ "hello world!" => "hello-html"
      , "unordered list" => "unordered-list"
      , "markdown" => "markdown"
      ]
  , "User Input" =>
      [ "buttons" => "buttons"
      , "field" => "field"
      , "form" => "form"
      , "checkboxes" => "checkboxes"
      , "radio buttons" => "radio-buttons"
      ]
  ]


effects : List Section
effects =
  [ "Commands" =>
      [ "random" => "random"
      , "http" => "http"
      ]
  , "Subscriptions" =>
      [ "time" => "time"
      , "websockets" => "websockets"
      , "mouse drags" => "drag"
      ]
  ]
