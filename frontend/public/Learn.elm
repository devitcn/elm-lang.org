import Graphics.Element (..)
import Markdown
import Signal (Signal, (<~))
import Website.Skeleton (skeleton)
import Window

main = skeleton "开始学习" content <~ Window.dimensions

content outer =
  let w = 600
      hwidth = if w < 800 then w // 2 - 20 else 380
      body =
          width w info
  in
      container outer (heightOf body) middle body

-- * [Learning roadmap](/learn/Roadmap.elm) &mdash; &ldquo;based on my background, what should I learn first?&rdquo;

info = Markdown.toElement """

# 开始学习

高手的话可以直接从[语法参考](/learn/Syntax.elm)开始看。
喜欢先从例子开始学习的人可以移步[代码样例](/Examples.elm)来逐步的学习。
这个页面提供一些系统的有深度的文档。

### 初学者课程

* [介绍用Elm编程](/learn/courses/beginner/Programming.elm) &mdash; 只有一点编程知识的人从这里看起。
* [介绍绘制图形](/learn/courses/beginner/Graphics.elm) &mdash; 用Elm画图
* [介绍 List 和 Record](/learn/courses/beginner/Lists-and-Records.elm) &mdash; Elm中比较常用的两个数据类型和其概念

### 基本资源

* [语法参考](/learn/Syntax.elm) &mdash; 全面的介绍ELm的语法
* [FAQ](/learn/FAQ.elm) &mdash; 常见问题解答

### 基础结构（Building Blocks）

* [理解数据类型](/learn/Understanding-Types.elm) &mdash; 原始值（primitive values），数据结构，和函数
* [共用体（Union Types）](/learn/Union-Types.elm) &mdash; 共用体，混合多个类型
* [记录（Records）](/learn/Records.elm) &mdash; 记录类型，可以有字段，有点像对象

### 信号（Signals）

* [关键概念](/learn/What-is-FRP.elm) &mdash; 信号的核心概念
* [使用信号](/learn/Using-Signals.elm) &mdash; 常见用法和坑
* [输入](/learn/Interactive-UI-Elements.elm) &mdash; 与表单控件交互
* [设计复杂程序](/learn/Architecture.elm) &mdash; 在复杂程序中用好信号

### 互操作（Interop）

* [HTML in Elm][elm-html] &mdash; 让HTML更简单
* [Elm in HTML](/learn/Components.elm) &mdash; 将ELm程序嵌入任何网页中
* [Ports](/learn/Ports.elm) &mdash; 与JavaScript通信


### 来做点什么（Making Stuff）

* [Website skeleton](https://github.com/evancz/elm-todomvc/blob/master/Todo.elm) &mdash; template for making websites with [elm-html][]
* [Game skeleton](https://github.com/elm-lang/elm-lang.org/blob/master/frontend/public/examples/Intermediate/GameSkeleton.elm) &mdash; template for making games, though many things fit this pattern
* [Making Pong](/blog/Pong.elm) &mdash; a full walkthrough of how to create Pong
* [Library Design Guidelines](http://package.elm-lang.org/help/design-guidelines) &mdash; creating pleasant and consistent libraries in Elm
* [Writing Docs](http://package.elm-lang.org/help/documentation-format) &mdash; an important thing to do!

[elm-html]: /blog/Blazing-Fast-Html.elm

### 线上杂志

* [Concurrent FRP for GUIs][thesis] &mdash; very accessible history of FRP and overview of Elm
* [Asynchronous FRP for GUIs][pldi] &mdash; formal semantics of Elm from PLDI 2013

 [thesis]: /papers/concurrent-frp.pdf "thesis"
 [pldi]: http://people.seas.harvard.edu/~chong/abstracts/CzaplickiC13.html "PLDI 2013 paper"

"""


