import Html exposing (..)
import Html.Attributes exposing (..)
import String

import Center
import Skeleton



main =
  Skeleton.skeleton
    "docs"
    [ Center.markdown "600px" content
    ]


content = """

# 文档

### 概述

  * **[开始安装](/get-started)**
  * [例子](/examples)
  * [Elm的架构](http://guide.elm-lang.org/architecture/)
  * [成为主流！](http://www.elmbark.com/2016/03/16/mainstream-elm-user-focused-design)


### 学习

  * **[学习指南](http://guide.elm-lang.org)**
  * [FAQ](http://elm-community.github.io/elm-faq/)
  * [语法参考](/docs/syntax)
  * [和JS的语法比较](/docs/from-javascript)
  * [Style Guide](/docs/style-guide)
  * [包的组织](http://package.elm-lang.org/help/design-guidelines)
  * [Doc的格式](http://package.elm-lang.org/help/documentation-format)
  * [异步、响应，记录集](/docs/advanced-topics)


### 库

  * **[All Community Packages](http://package.elm-lang.org)**
  * [Core](http://package.elm-lang.org/packages/elm-lang/core/latest/)
  * [HTML](http://package.elm-lang.org/packages/elm-lang/html/latest/)


"""
