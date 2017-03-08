import Html exposing (..)
import Html.Attributes exposing (..)

import Blog
import Center


(=>) = (,)


main =
  Blog.docs
    "Elm 语法"
    [ Center.markdown "600px" content ]

content = """

这份语法参考涉及：

- [注释](#comments)
- [常量](#literals)
- [列表](#lists)
- [分支](#conditionals)
- [Union Types](#union-types)
- [记录](#records)
- [函数](#functions)
- [Infix Operators](#infix-operators)
- [Let Expressions](#let-expressions)
- [Applying Functions](#applying-functions)
- [模块](#modules)
- [注解](#type-annotations)
- [别名](#type-aliases)
- [与JavaScript互操作](#javascript-interop)

Check out the [learning resources](/Learn.elm) for
tutorials and examples on actually *using* this syntax.

### 注释（Comments）

```elm
-- 单行注释

{- 多行注释
   {- can be nested -}
-}
```

小技巧，注释开关：

```elm
{--}
add x y = x + y
--}
```

添加或移除第一行的`}`可以让整个段落在注释和源码间来回切换。

### 常量（Literals）

```elm
-- 布尔值
True  : Bool
False : Bool

42    : number  -- 根据运算来决定是Int还是Float
3.14  : Float --浮点数

'a'   : Char --单个字符
"abc" : String --字符串

-- 多行字符串
\"\"\"
This is useful for holding JSON or other
content that has "quotation marks".
\"\"\"
```

典型常量运算表达式：

```elm
True && not (True || False)
(2 + 4) * (4^2 - 9)
"abc" ++ "def"
```

### 数组、列表（Lists）

这三种写法的结果相等（“::”是合并操作）：

```elm
[1,2,3,4]
1 :: [2,3,4]
1 :: 2 :: 3 :: 4 :: []
```

### 条件表达式（Conditionals）

```elm
if powerLevel > 9000 then "OVER 9000!!!" else "meh"
```

多个分支条件：

```elm
if key == 40 then
    n + 1

else if key == 38 then
    n - 1

else
    n
```

分支条件也可以基于数据结构和类型判断（case of）来做：

```elm
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

在用这种写法的时候，子条件的缩进必须对齐。

### 共用体（Union Types）

```elm
type List = Empty | Node Int List
```
List的类型是Empty和Node两者的其中之一，[具体解释](http://guide.elm-lang.org/types/union_types.html)。

### 记录集（Records）

有关Elm语言中记录集模块的详细介绍可以看[这篇概述][exp]，或[更新日志][v7]，或者[这篇论文][records]。

  [exp]: /docs/records "Records in Elm"
  [v7]:  /blog/announce/0.7 "Elm version 0.7"
  [records]: http://research.microsoft.com/pubs/65409/scopedlabels.pdf "Extensible records with scoped labels"

```elm
point =                         -- 创建一个Record
  { x = 3, y = 4 }

point.x                         -- 访问字段

List.map .x [point,{x=0,y=0}]   -- field access function

{ point | x = 6 }               -- 更新字段的值

{ point |                       -- 同时更新多个字段的值
    x = point.x + 1,
    y = point.y + 1
}

dist {x,y} =                    -- pattern matching on fields
  sqrt (x^2 + y^2)

type alias Location =           -- type aliases for records
  { line : Int
  , column : Int
  }
```

### 函数（Functions）

```elm
square n =
  n^2

hypotenuse a b =
  sqrt (square a + square b)

distance (a,b) (x,y) =
  hypotenuse (a-x) (b-y)
```

匿名函数：

```elm
square =
  \\n -> n^2

squares =
  List.map (\\n -> n^2) (List.range 1 100)
```

### 管道操作（Infix Operators）

可以创建自己的中缀操作符。
[优先级](http://en.wikipedia.org/wiki/Order_of_operations)从0到9，9最高。默认的优先级是9，
[结合顺序](http://en.wikipedia.org/wiki/Operator_associativity)是从右向左，你可以改变这个设置。
但不能改变内置操作符的结合顺序。

You can create custom infix operators.
[Precedence]() goes from 0 to
9, where 9 is the tightest. The default precedence is 9 and the default
[associativity](http://en.wikipedia.org/wiki/Operator_associativity) is left.
You can set this yourself, but you cannot override built-in operators.

```elm
(?) : Maybe a -> a -> a
(?) maybe default =
  Maybe.withDefault default maybe

infixr 9 ?
```

使用 [`(<|)`](http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#<|)
和 [`(|>)`](http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#|>)
可以减少使用括号的频率，让代码读起来自然一些。实际执行是和函数调用（函数的别名）一样的。

```elm
viewNames1 names =
  String.join ", " (List.sort names)

viewNames2 names =
  names
    |> List.sort
    |> String.join ", "

-- (arg |> func) is the same as (func arg)
-- Just keep repeating that transformation!
```

历史渊源：这个思路是从F#中借鉴的，Unix 中的管道操作将之发扬光大。

Relatedly, [`(<<)`](http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#<<)
and [`(>>)`](http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#>>>)
are function composition operators.


### Let Expressions

Let expressions are for assigning variables, kind of like a `var` in
JavaScript.

```elm
let
  twentyFour =
    3 * 8

  sixteen =
    4 ^ 2
in
  twentyFour + sixteen
```

You can define functions and use &ldquo;destructuring assignment&rdquo; in let
expressions too.

```elm
let
  ( three, four ) =
    ( 3, 4 )

  hypotenuse a b =
    sqrt (a^2 + b^2)
in
  hypotenuse three four
```

Let表达式对缩进格式敏感，每个必须和上一个对齐。

Finally, you can add type annotations in let-expressions.

```elm
let
  name : String
  name =
    "Hermann"

  increment : Int -> Int
  increment n =
    n + 1
in
  increment 10
```

It is best to only do this on *concrete* types. Break generic functions into
their own top-level definitions.


### 函数调用（Applying Functions）

```elm
-- alias for appending lists and two lists
append xs ys = xs ++ ys
xs = [1,2,3]
ys = [4,5,6]

-- 以下写法等价
a1 = append xs ys
a2 = xs ++ ys

b2 = (++) xs ys

c1 = (append xs) ys
c2 = ((++) xs) ys
```

类型推断实例；

```elm
23 + 19    : number
2.0 + 1    : Float

6 * 7      : number
10 * 4.2   : Float

100 // 2  : Int
1 / 2     : Float
```

还有一个的特别的函数用来构造元组：

```elm
(,) 1 2              == (1,2)
(,,,) 1 True 'a' []  == (1,True,'a',[])
```

逗号数量不限。


### 模块（Modules）

```elm
module MyModule exposing (..)

-- qualified imports
import List                    -- List.map, List.foldl
import List as L               -- L.map, L.foldl

-- open imports
import List exposing (..)               -- map, foldl, concat, ...
import List exposing ( map, foldl )     -- map, foldl

import Maybe exposing ( Maybe )         -- Maybe
import Maybe exposing ( Maybe(..) )     -- Maybe, Just, Nothing
import Maybe exposing ( Maybe(Just) )   -- Maybe, Just
```

Qualified imports are preferred. Module names must match their file name,
so module `Parser.Utils` needs to be in file `Parser/Utils.elm`.


### 类型声明（Type Annotations）

```elm
answer : Int
answer =
  42

factorial : Int -> Int
factorial n =
  List.product [1..n]

distance : { x : Float, y : Float } -> Float
distance {x,y} =
  sqrt (x^2 + y^2)
```

Learn how to read types and use type annotations
[here](http://guide.elm-lang.org/types/reading_types.html).


### 类型别名（Type Aliases）

```elm
type alias Name = String
type alias Age = Int

info : (Name,Age)
info =
  ("Steve", 28)

type alias Point = { x:Float, y:Float }

origin : Point
origin =
  { x = 0, y = 0 }
```

Learn more about type aliases
[here](http://guide.elm-lang.org/types/type_aliases.html).


### JavaScript Interop

```elm
-- incoming values
port prices : (Float -> msg) -> Sub msg

-- outgoing values
port time : Float -> Cmd msg
```

From JS, you talk to these ports like this:

```javascript
var app = Elm.Example.worker();

app.ports.prices.send(42);
app.ports.prices.send(13);

app.ports.time.subscribe(callback);
app.ports.time.unsubscribe(callback);
```

Read more about [HTML embedding][html] and [JavaScript interop][js].

[html]: http://guide.elm-lang.org/interop/javascript.html#step-1-embed-in-html
[js]: http://guide.elm-lang.org/interop/javascript.html


"""
