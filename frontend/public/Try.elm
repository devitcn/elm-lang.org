import Markdown
import Website.Message exposing (report)

main = report <| Markdown.toElement """

# 在线体验

在线编写然后编译执行！

  * <a href="/edit/examples/Elements/HelloWorld.elm" target="_top">Hello World!</a>
  * <a href="/edit/examples/Reactive/Position.elm" target="_top">Mouse</a>
  * <a href="/edit/examples/Intermediate/Clock.elm" target="_top">Clock</a>

要获得更多指导请点击：

  * <a href="/Examples.elm" target="_top">代码样例</a>
  * <a href="/Learn.elm" target="_top">开始学习</a>

"""
