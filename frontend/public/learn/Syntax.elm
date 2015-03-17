import Graphics.Element (..)
import Markdown
import Signal (Signal, (<~))
import Website.Skeleton (skeleton)
import Window


port title : String
port title = "Elm语法参考"


main : Signal Element
main =
  skeleton "开始学习" content <~ Window.dimensions


content : Int -> Element
content w =
  width (min 600 w) intro


intro : Element
intro = Markdown.toElement """

# Elm语法参考

Elm的基本语法参考:

- [注释（Comments）](#-comments-)
- [常量（Literals）](#-literals-)
- [数组（Lists）](#-lists-)
- [条件表达式（Conditionals）](#-conditionals-)
- [共用体（Union Types）](#-union-types-)
- [记录（Records）](#-records-)
- [函数（Functions）](#-functions-)
- [Infix Operators](#-infix-operators-)
- [Let表达式（Let Expressions）](#-let-expressions-)
- [Applying Functions](#-applying-functions-)
- [Mapping with `(<~)` and `(~)`](#-mapping-)
- [模块（Modules）](#-modules-)
- [类型声明（Type Annotations）](#-type-annotations-)
- [类型别名（Type Aliases）](#-type-aliases-)
- [JavaScript FFI](#-javascript-ffi-)
- [还*不*支持的东西](#-things-not-in-elm-)

Check out the [learning resources](/Learn.elm) for
tutorials and examples on actually *using* this syntax.

### 注释（Comments）

```haskell
--单行注释

{- 多行注释
   {- 也能嵌套 -}
-}
```

介绍一个小技巧：

```haskell
{--}
add x y = x + y
--}
```
去掉第一行的“}”可以注释整个段落，可以方便的注释一段代码。

### 常量（Literals）

```haskell
-- 布尔值 Boolean
True  : Bool
False : Bool

42    : number  -- 根据运算场景来决定具体是整型还是浮点
3.14  : Float --小数

'a'   : Char -- 字符
"abc" : String --字符串

-- 多行字符串
\"\"\"
This is useful for holding JSON or other
content that has "quotation marks".
\"\"\"
```

典型常量运算表达式：

```haskell
True && not (True || False)
(2 + 4) * (4^2 - 9)
"abc" ++ "def"
```

### 数组、列表（Lists）

下面这四种写法含义相等（“::”是合并操作）：

```haskell
[1..4]
[1,2,3,4]
1 :: [2,3,4]
1 :: 2 :: 3 :: 4 :: []
```

### 条件表达式（Conditionals）

```haskell
if powerLevel > 9000 then "OVER 9000!!!" else "meh"
```

还有一种多路分支的简便写法如下，其中“|”可视作“当……”，“->”后面的是返回值，“otherwise”代表其他情况。

```haskell
if | key == 40 -> n+1
   | key == 38 -> n-1
   | otherwise -> n
```

分支条件也可以基于数据结构和类型判断（case of）来做：

```haskell
case maybe of
  Just xs -> xs
  Nothing -> []

case xs of
  hd::tl -> Just (hd,tl)
  []     -> Nothing

case n of
  0 -> 1
  1 -> 1
  _ -> fib (n-1) + fib (n-2)
```

在用这两种写法的时候，要注意对齐子条件的缩进。

### 共用体（Union Types）

```haskell
type List = Empty | Node Int List
```

List的类型是Empty和Node两者的其中之一，[具体请看详细解释](/learn/Pattern-Matching.elm)。

### 记录集（Records）

有关Elm语言中记录集模块的详细介绍可以看[这篇概述][exp]，或[更新日志][v7]，或者[这篇学术论文][records].

  [exp]: /learn/Records.elm "Records in Elm"
  [v7]:  /blog/announce/0.7.elm "Elm version 0.7"
  [records]: http://research.microsoft.com/pubs/65409/scopedlabels.pdf "Extensible records with scoped labels"

```haskell
point = { x = 3, y = 4 }       -- 构造一个记录对象

point.x                        -- 访问其中的“x”字段
map .x [point,{x=0,y=0}]       -- field access function

{ point - x }                  -- 删除一个字段
{ point | z = 12 }             -- 添加一个字段
{ point - x | z = point.x }    -- 字段改名
{ point - x | x = 6 }          -- 更新值

{ point | x <- 6 }             -- 优雅的更新一个字段
{ point | x <- point.x + 1
        , y <- point.y + 1 }   -- 批量更新多个字段

dist {x,y} = sqrt (x^2 + y^2)  -- 字段匹配模式（在这个函数中，变量直接中记录集中查找）
\\{x,y} -> (x,y)

lib = { id x = x }             -- 字段支持多态
(lib.id 42 == 42)
(lib.id [] == [])

type alias Location = { line:Int, column:Int }
```

### 函数（Functions）

```haskell
square n = n^2

hypotenuse a b = sqrt (square a + square b)

distance (a,b) (x,y) = hypotenuse (a-x) (b-y)
```

匿名函数：

```haskell
square = \\n -> n^2 -- fn n = n^2 \\n是传入的参数
squares = map (\\n -> n^2) [1..100]
```

### Infix Operators

You can create custom infix operators. The default
[precedence](http://en.wikipedia.org/wiki/Order_of_operations)
is 9 and the default
[associativity](http://en.wikipedia.org/wiki/Operator_associativity)
is left, but you can set your own.
You cannot override the built-in operators though.

```haskell
f <| x = f x

infixr 0 <|
```

Use [`(<|)`](http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#<|)
and [`(|>)`](http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#|>)
to reduce parentheses usage. They are aliases for function
application.

```haskell
f <| x = f x
x |> f = f x

dot =
  scale 2 (move (20,20) (filled blue (circle 10)))

dot' =
  circle 10
    |> filled blue
    |> move (20,20)
    |> scale 2
```

Historical note: this is borrowed from F#, inspired by Unix pipes,
improving upon Haskell&rsquo;s `($)`.

### Let表达式（Let Expressions）

```haskell
let n = 42
    (a,b) = (3,4)
    {x,y} = { x=3, y=4 }
    square n = n * n
in
    square a + square b
```

Let表达式对缩进格式敏感。

### 函数调用（Applying Functions）

```haskell
-- alias for appending lists and two lists
append xs ys = xs ++ ys
xs = [1,2,3]
ys = [4,5,6]

-- 调用的写法有多种，下面这些都是等价的：
a1 = append xs ys
a2 = (++) xs ys

b1 = xs `append` ys
b2 = xs ++ ys

c1 = (append xs) ys
c2 = ((++) xs) ys
```

The basic arithmetic infix operators all figure out what type they should have automatically.

```haskell
23 + 19    : number
2.0 + 1    : Float

6 * 7      : number
10 * 4.2   : Float

100 // 2  : Int
1 / 2     : Float
```

有一个的特别的函数用来构造元组：

```haskell
(,) 1 2              == (1,2)
(,,,) 1 True 'a' []  == (1,True,'a',[])
```

逗号数量不限。

### Mapping

The `map` functions are used to apply a normal function like `sqrt` to a signal
of values such as `Mouse.x`. So the expression `(map sqrt Mouse.x)` evaluates
to a signal in which the current value is equal to the square root of the current
x-coordinate of the mouse.

You can also use the functions `(<~)` and `(~)` to map over signals. The squiggly
arrow is exactly the same as the `map` function, so the following expressions
are the same:

```haskell
map sqrt Mouse.x
sqrt <~ Mouse.x
```

You can think of it as saying &ldquo;send this signal through this
function.&rdquo;

The `(~)` operator allows you to apply a signal of functions to a signal of
values `(Signal (a -> b) -> Signal a -> Signal b)`. It can be used to put
together many signals, just like `map2`, `map3`, etc. So the following
expressions are equivalent:

```haskell
map2 (,) Mouse.x Mouse.y
(,) <~ Mouse.x ~ Mouse.y

map2 scene (fps 50) (sampleOn Mouse.clicks Mouse.position)
scene <~ fps 50 ~ sampleOn Mouse.clicks Mouse.position
```

More info can be found [here](/blog/announce/0.7.elm#do-you-even-lift)
and [here](http://package.elm-lang.org/packages/elm-lang/core/latest/Signal).

### 模块（Modules）

```haskell
module MyModule where

-- qualified imports
import List                    -- List.map, List.foldl
import List as L               -- L.map, L.foldl

-- open imports
import List (..)               -- map, foldl, concat, ...
import List ( map, foldl )     -- map, foldl

import Maybe ( Maybe )         -- Maybe
import Maybe ( Maybe(..) )     -- Maybe, Just, Nothing
import Maybe ( Maybe(Just) )   -- Maybe, Just
```

Qualified imports are preferred.模块的名字需要和文件名匹配（和JAVA一样），像`Parser.Utils`的模块名，必须放在`Parser/Utils.elm`里面。

### 类型声明（Type Annotations）

```haskell
answer : Int -- 声明一个整型变量
answer = 42

factorial : Int -> Int --声明一个函数，参数是整型，返回值是整型
factorial n = product [1..n]

addName : String -> a -> { a | name:String } --声明一个函数，参数是字符串、记录集，返回值是记录集
addName name record = { record | name = name }
```

### 类型的别名（Type Aliases）

```haskell
type alias Name = String
type alias Age = Int

info : (Name,Age)
info = ("Steve", 28)

type alias Point = { x:Float, y:Float }

origin : Point
origin = { x=0, y=0 }
```

### 与Javascript交互（JavaScript FFI）

```haskell
-- incoming values
port userID : String
port prices : Signal Float

-- outgoing values
port time : Signal Float
port time = every second

port increment : Int -> Int
port increment = \\n -> n + 1
```

From JS, you talk to these ports like this:

```javascript
var example = Elm.worker(Elm.Example, {
  userID:"abc123",
  prices:11
});

example.ports.prices.send(42);
example.ports.prices.send(13);

example.ports.time.subscribe(callback);
example.ports.time.unsubscribe(callback);

example.ports.increment(41) === 42;
```

More example uses can be found
[here](https://github.com/evancz/elm-html-and-js)
and [here](https://gist.github.com/evancz/8521339).

Elm has some built-in port handlers that automatically take some
imperative action:

 * [`title`](/edit/examples/Reactive/Title.elm) sets the page title, ignoring empty strings
 * [`log`](/edit/examples/Reactive/Log.elm) logs messages to the developer console
 * [`redirect`](/edit/examples/Reactive/Redirect.elm) redirects to a different page, ignoring empty strings

Experimental port handlers:

 * `favicon` sets the pages favicon
 * `stdout` logs to stdout in node.js and to console in browser
 * `stderr` logs to stderr in node.js and to console in browser

### 尚未实现（Things *not* in Elm）

Elm currently does not support:

- operator sections such as `(+1)`
- guarded definitions or guarded cases. Use the multi-way if for this.
- `where` clauses
- any sort of `do` or `proc` notation

"""
