# 创建Elm 官网的模板程序

这项目包含了运行[elm-lang.org](http://elm-lang.org/)主站的所有源文件。你可以用来创建自己的 Elm 网站。其中有一个Http服务器用来执行Elm代码和其他静态资源。

这个还能用来运行[elm-lang.org/try](http://elm-lang.org/try) 。

### 本地安装步骤

首先需要安装 Elm 编译器([步骤](https://github.com/evancz/Elm#elm)).

然后执行下述步骤可以让启动网站：

```bash
git clone https://github.com/elm-lang/elm-lang.org.git
cd elm-lang.org
git checkout stable
elm-package install
cabal configure
cabal install --only-dependencies
cabal build
./dist/build/run-elm-website/run-elm-website
```

啊哈！这样[elm-lang.org](http://elm-lang.org/) 就会运行在[localhost:8000/](http://localhost:8000/).

运行 `cabal clean` 可以清空缓存重新编译。

### 项目结构

- `public/` &mdash; 所有供客户端访问的“.elm”文件，你可以编辑。

- `resources/` &mdash; 存放网页上需要的各类静态资源文件。图片、视频、JS等等。

- `server/` &mdash; Haskell 编写的小型服务器，用来服务 elm文件和静态资源。 Look here if you need to change how a particular
  resource is served or if you want to disable some of the sites features (such
  as the online editor).

