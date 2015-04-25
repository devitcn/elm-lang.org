import Graphics.Element exposing (..)
import Markdown
import Website.Skeleton exposing (skeleton)
import Window


main : Signal Element
main =
  Signal.map (skeleton "开始学习" (\w -> width (min 600 w) content)) Window.dimensions


content : Element
content = Markdown.toElement """

# 学习指南（Learning Roadmap）

This page provides advice on how to learn Elm based on your background.
Multiple sections may apply to you, so keep reading even if you found a
good starting point!

And if you are coming to Elm from Haskell or JavaScript, see these
[tips](/learn/FAQ.elm).

### 如果刚开始学习编程（New to programming）

 * watch the [beginner classes](/Learn.elm#beginner-classes) and do the exercises!

### 如果刚刚接触函数式编程（New to functional programming）

 * [syntax reference](/learn/Syntax.elm)
 * [topic tutorials](/Learn.elm#topic-tutorials)
 * [examples of functional concepts](/Examples.elm#compute)

### 如果刚刚接触函数式、反应式编程（New to Functional Reactive Programming）

 * [an introduction to FRP](/learn/What-is-FRP.elm)
 * [basic examples of FRP in action](/Examples.elm#react)
 * [video explaning FRP](http://www.infoq.com/presentations/elm-reactive-programming)
   in a fun and accessible way
 * [thesis](/papers/concurrent-frp.pdf)
   explaining how FRP works in Elm, very accessible despite the format!

### 如果刚看ELm（Using Elm）

 * see the [intermediate](/Examples.elm#intermediate) and [big examples](/Examples.elm#big-examples)
 * [skeletons for making websites and games](/Learn.elm#making-stuff)
 * [release notes](/Blog.elm#release-notes) which may contain information that has not yet made it into docs
 * [blog posts](/Blog.elm)
 * follow [/r/elm](http://www.reddit.com/r/elm) and read peoples' code
"""
