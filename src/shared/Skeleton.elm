module Skeleton exposing (skeleton)

import Html exposing (..)
import Html.Attributes exposing (..)


(=>) = (,)


skeleton tabName content =
  div []
    (header tabName :: content ++ [footer])



-- HEADER


header name =
  div [ id "tabs" ]
    [ a [ href "/"
        , style
            [ "position" => "absolute"
            , "left" => "1em"
            , "top" => "1em"
            ]
        ]
        [ img [ src "/assets/logo.svg", style [ "width" => "24px" ] ] []
        ]
    , ul [] (List.map (tab name) [ ("examples","例子"), ("docs","文档"), ("community","社区"), ("blog","博客") ])
    ]


tab currentName (name , title) =
  li []
    [ a [ classList [ "tab" => True, "current" => (currentName == name) ]
        , href ("/" ++ name)
        ]
        [ text title ]
    ]



-- FOOTER


footer =
  div [class "footer"]
    [ text "网站源码也是用Elm写的，并且"
    , a [ class "grey-link", href "https://github.com/elm-lang/elm-lang.org/" ] [ text "开源" ]
    , text "。简体中文由 Alex Lei "
    , a [ class "grey-link", href "https://github.com/devitcn/elm-lang.org" ] [ text "翻译" ]
    , text "。 — © 2012-2017 版权所有 Evan Czaplicki"
    ]

