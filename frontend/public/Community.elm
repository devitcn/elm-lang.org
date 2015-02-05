import Graphics.Element (..)
import Markdown
import Signal (Signal, (<~))
import Website.Skeleton (skeleton)

import Window

port title : String
port title = "社区和支持"

main = skeleton "社区和支持" content <~ Window.dimensions

content outer =
    let center elem =
            container outer (heightOf elem) middle elem
    in  center (width (min 600 outer) community)

community = Markdown.toElement """

# 社区和支持

### 邮件列表

[list]: https://groups.google.com/forum/?fromgroups#!forum/elm-discuss "mailing list"

[Google Group上的邮件列表][list]是讨论问题的好地方(-_-!)。 常见话题有API设计、文档、库还有合作开发。
另外还有一个分享代码片段的好地方：[share-elm.com](http://www.share-elm.com).

邮件列表是学习和提高的地方，所以即使你已经知道了很多ELm的东西，也记得要谦虚谨慎，保持学习的心态。
试着翻一翻历史邮件感受一下学习氛围或者认识其他的人。

### Reddit

[reddit]: http://www.reddit.com/r/elm

在[reddit/r/elm][reddit]上可以找到博客和类库还有学习文章，也可以发布你的博客和类库。!

### IRC

[irc]: http://webchat.freenode.net/?channels=elm

在[IRC#elm频道上][irc]可以向在线的其他人直接提问。

在提问的时候记得注意礼貌，你可能会碰到高手或者新手，提问之前组织一下语言，再反问一下自己这样问是否合适。


### Twitter

[twitter]: https://twitter.com/elmlang

[@elmlang][twitter]和[@czaplic](https://twitter.com/czaplic)上的推文都是关于ELm的。
最常用的标签是：#elmlang，用#elm倒是也可以，但有时会有点歧义。

### 线下聚会

[Evan Czaplicki](http://github.com/evancz) will periodically organize [Elm user
group](http://www.meetup.com/Elm-user-group-SF/) meetups in SF to talk about
language design or discuss upcoming features and challenges. Email the mailing
list know if you want to give a talk or organize more frequent meetings!

There are also a ton of Elm folks on the East coast, so Boston and New York
would both be great places for meetups. The European community is also quite
strong. We had [Elm Workshop](/blog/announce/Workshop-2013.elm) in 2013
with speakers and attendees from all over Europe, so more of this!

### 做贡献

Elm组织负责的项目都放在[Github](http://github.com/elm-lang)上了，你可以fork出来共同开发，这其中有编译器、REPL、服务器、包管理器、调试器、公共类库、还有这个网站。

还有一个做贡献的好办法就是参加[邮件列表][list]中的热门讨论，可以更清晰的让社区知道你能够在哪些地方帮助Elm项目成长。

"""

