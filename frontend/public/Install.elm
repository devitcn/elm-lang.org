import Graphics.Element (..)
import Markdown
import Signal (Signal, (<~))
import Website.Widgets (button)
import Website.Skeleton (skeleton)
import Website.BigTiles as Tile
import Website.ColorScheme as C

import Text
import Window

port title : String
port title = "下载安装"

main = skeleton "下载安装" content <~ Window.dimensions

content outer =
    let center elem =
            container outer (heightOf elem) middle elem
    in
        flow down
        [ center (width (min 600 outer) header)
        , center <|
              flow right
              [ button 220 180 "http://install.elm-lang.org/Elm-Platform-0.14.1.pkg" "Mac"
              , button 220 180 "http://install.elm-lang.org/Elm-Platform-0.14.1.exe" "Windows"
              ]
        , center (width (min 600 outer) rest)
        ]


header = Markdown.toElement """

# 安装

已经为Mac和Windows用户准备好了安装程序方便安装。其他平台的话需要[从源代码编译](#build-from-source)。

"""


rest = Markdown.toElement """

如需从旧版本升级，只需下载新的安装包重新安装即可，安装程序会覆盖旧的运行环境。

如需卸载，Windows用户可在控制面板，添加删除软件中卸载，Mac用户需要下载执行[这个卸载脚本][uninstall].

[uninstall]: https://github.com/elm-lang/elm-platform/blob/master/installers/mac/helper-scripts/uninstall.sh

<br>

## 语法高亮支持

有几个编辑器已经支持Elm语法高亮，有的还集成了交互式开发功能（REPL），这里列出几个参考链接：

  * [Sublime Text](https://github.com/deadfoxygrandpa/Elm.tmLanguage)
  * [Atom](https://atom.io/packages/language-elm)
  * [Emacs](https://github.com/jcollard/elm-mode)
  * [Vim](https://github.com/lambdatoast/elm.vim)

再配合上[Elm Reactor](/blog/Introducing-Elm-Reactor.elm)就有了一个完整的开发环境了。

<br>

<span id="build-from-source"></span>
## 从源代码编译

这份指导应该能在大多数平台（Windows、Linux）上安装上ELm环境，安装之前需要用一下Haskell compiler（用完就可以删除了）。

**如果以前没用 Haskell**，先要[从这下载安装Haskell Platform][hp]。
然后执行这些命令：

```bash
cabal update
cabal install cabal-install
cabal install -j elm-compiler-0.14.1 elm-package-0.4 elm-make-0.1.1
cabal install -j elm-repl-0.4 elm-reactor-0.3
```

需要花点时间来编译程序，完成后就添加到了PATH变量中了。要是没有的话可能会在这个地方：`~/.cabal/bin`，[然后手工填加一下到PATH][add-path].

[hp]: http://hackage.haskell.org/platform/
[add-path]: http://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path

**如果你还用Haskell开发其他程序**，那最好还是用cabal沙箱来安装Elm环境，[参看这个脚本][script]，cabal 0.18以上支持。

附注：如果想在虚拟机环境中快速体验的话也可以用这个：
```bash
#Tested on ubuntu12.04
#download Haskell platform
cd /
sudo wget https://www.haskell.org/platform/download/2014.2.0.0/haskell-platform-2014.2.0.0-unknown-linux-x86_64.tar.gz
sudo tar xvf ...downloaded-tarfile...
sudo /usr/local/haskell/ghc-7.8.3-x86-64/bin/activate-hs

#download elm and install global
cabal update
cabal install -j --global elm-compiler-0.14.1 elm-package-0.4 elm-make-0.1.1
cabal install -j --global elm-repl-0.4 elm-reactor-0.3

```

[script]: https://github.com/elm-lang/elm-platform/blob/master/installers/BuildFromSource.hs#L1-L31

<br>

## 创建第一个项目

最简单的方法是下载运行这个[Elm示例项目][] 。
里面有几个简单的ELm程序可以运行。[使用Elm Reactor来运行][reactor].

[elm-examples]: https://github.com/evancz/elm-examples
[reactor]: https://github.com/elm-lang/elm-reactor

<br>

## 附加工具

Elm Platform 中包含了几个非常有用的工具，`elm-reactor`是其中之一，下面介绍一下其他三个的功能：

  * [`elm-make`](https://github.com/elm-lang/elm-make) &mdash;
    用来将Elm程序编译成HTML和JavaScript。最原始的编译程序，如果你的项目比较复杂而超过`elm-reactor` 处理能力，你可以需要直接使用编译器来编译。

  * [`elm-repl`](https://github.com/elm-lang/elm-repl) &mdash;
    REPL是一个交互式的执行环境（[read-eval-print-loop][repl]），能够让你执行一些小的Elm表达式。
    也能够从项目目录导入代码，所以能够方便的测试一个模块的内部功能。
    `elm-repl`最终需要执行JavaScript代码，所以需要安装[node.js](http://nodejs.org/)
    才能工作。

  * [`elm-package`](https://github.com/elm-lang/elm-package) &mdash;
    用来从[Elm Package
    Catalog](http://package.elm-lang.org/)下载依赖包。一个由社区共同维护的Elm代码库。

所有工具都支持“`--help`”参数来查询详细信息。在[GitHub](http://github.com/elm-lang)还有README文档可以参阅。

  [repl]: http://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop

<br>

## 求助

如果遇到问题，可以先看看是否有人[遇到了同样的问题][elm-platform]。
没有的话，可以提交问题或发邮件到[邮件列表][group]或者在[#elm IRC 频道][irc]提问。

[elm-platform]: https://github.com/elm-lang/elm-platform/issues
[group]: https://groups.google.com/forum/?fromgroups#!forum/elm-discuss
[irc]: http://webchat.freenode.net/?channels=elm

"""

