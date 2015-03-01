import Graphics.Element (..)
import Markdown
import Signal (Signal, (<~))
import Website.Skeleton (skeleton)
import Window


port title : String
port title = "介绍绘图"


main : Signal Element
main =
  skeleton "开始学习" everything <~ Window.dimensions


everything : Int -> Element
everything wid =
  let w  = truncate (toFloat wid * 0.8)
      w' = min 600 w
      section txt =
          let words = width w' txt in
          container w (heightOf words) middle words
  in
  flow down
  [ width w pageTitle
  , section preface
  , width w video
  , section intro
  ]


pageTitle = Markdown.toElement """
<br/>
<div style="font-family: futura, 'century gothic', 'twentieth century', calibri, verdana, helvetica, arial; text-align: center;">
<div style="font-size: 4em;">Introduction to Graphics</div>
</div>
"""


preface = Markdown.toElement """

Now that you have been [introduced to programming](/learn/courses/beginner/Programming.elm),
you are about to learn the basics of graphics in Elm.
The following video, [written explanation](#words), and [practice problems](#practice-problems)
are designed to help you dive into working with images, text, and shapes.

The video is followed by a written explanation that covers exactly the
same material. You can use the [online editor](http://elm-lang.org/try) to
follow along and start experimenting on your own.
"""

video = Markdown.toElement """
<div style="position: relative; padding-bottom: 56.25%; padding-top: 30px; height: 0; overflow: hidden;">
<iframe src="//www.youtube.com/embed/7mMBWfBpyYg?rel=0&html5=1"
        frameborder="0"
        allowfullscreen
        style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"
        width="853" height="480"></iframe>
</div>
"""

intro = Markdown.toElement """

<span id="words"></span><br/>
Okay, now we are going to cover the same material, but in text form.

This covers basic graphics in Elm.
We will first cover images and text. From there we will learn how to
put many graphical elements together. Once we are good at putting
rectangular shapes together, we will branch out to the wild west
of triangles, pentagons, and circles.

# 元素（Elements）

在Elm中基本可绘制的东西都叫做*元素（elements）*。一个元素是一个有宽度和高度的长方形。 in Elm. An element is a rectangle
with a known width and height. Unlike triangles and pentagons, rectangles are
no-nonsense shapes that can be put together very easily.

有许多内建函数可以帮助创建图形元素。这里先讲图片和文本。

### 图片（Images）

让我们用一张小熊的图片开始。

```haskell
main = image 200 200 "/yogi.jpg"
```

图片有宽度、高度、和文件路径三个参。
文件可以是网络能访问到的任意图片。这个例子中选择了本地的瑜伽熊，你可以替换成其他的图片，
[Hermann Hesse](http://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Hermann_Hesse_2.jpg/501px-Hermann_Hesse_2.jpg)
或 [Saturn](http://upload.wikimedia.org/wikipedia/commons/2/25/Saturn_PIA06077.jpg)

Maybe we decide to look at some shells from South Africa:

```haskell
main = image 400 200 "/shells.jpg"
```

图片看上去有点变形。是因为`image`函数将图片拉伸以适应指定的宽度和高度参数。让我们稍作调整。

```haskell
main = fittedImage 400 200 "/shells.jpg"
```

好多了（框还是400 200大小）。

### 文字（Text）

In the first class, we used `asText` to show
very simple values, but it always used a monospace font.
It is not great for normal blocks of text. For that we use
[Markdown](http://daringfireball.net/projects/markdown/), a
nice format for describing styled text:

```haskell
main = Markdown.toElement \"\"\"

# Making Fancy Text

You need to have an empty line to start a new
paragraph. Let’s try it.

Yep, this is definitely a new paragraph.
You can also make a list of things. Let’s make a
list of kinds of fancy text:

  1. *italic*
  2. **bold**
  3. `computery`
  4. [links to things](http://xkcd.com/323/)

\"\"\"
```

Markdown is supposed to look a lot like the styled text it produces.
So bullet points look a lot like bullet points, and paragraphs are actually
separated like paragraphs. It tends to do the right thing, but if not,
you can look up the details [here](http://daringfireball.net/projects/markdown/syntax).

### Stacking Things

Now that we have some basic elements, the next step is to start putting them
together. We do this with the `flow` function.

```haskell
tongueTwister =
    Markdown.toElement "She sells sea shells by the sea shore."

main =
    flow down
    [ tongueTwister
    , fittedImage 300 200 "/shells.jpg"
    ]
```

You can change down to be lots of different things. Your options are:
`up`, `down`, `left`, `right`, `inward`, and `outward`. They do what
they say they do. Try some of them!

# 形状（Forms）

Rectangles are cool and all, but sometimes you just need a pentagon.
In Elm, irregular shapes that cannot be stacked easily are called *forms*.
These visual forms have shape, color, and many more properties and can be
displayed any which way on a [collage](http://en.wikipedia.org/wiki/Collage).
We will start with a red pentagon:

```haskell
main = collage 400 400 [ filled red (ngon 5 100) ]
```

A `collage` is an element with a width and a height. It is just like images and text;
it is an easily stackable rectangle. The cool part is that a collage takes
a list of forms. In this case, we gave it a pentagon (an N-gon with five sides)
that has a radius of 100 pixels. We then filled the pentagon with red.

We could just have easily outlined that pentagon with green.

```haskell
main = collage 400 400
         [ outlined (dashed green) (ngon 5 100) ]
```

It does not need to be a dashed line though, it could also be
[`solid` or `dotted`](/examples/Elements/Lines.elm).

### Moving, Rotating, and Scaling

The best part of forms is that we can [move, rotate, and scale
them](/edit/examples/Elements/Transforms.elm).

```haskell
main =
  collage 400 400
    [ move (100,100) (filled red (square 40))
    , scale 2 (filled green (square 40))
    , rotate (degrees 45) (filled blue (square 40))
    ]
```

But we are starting to repeat ourselves. We wrote the same code
for all three forms. We can break this out into functions to make
this easier to read.

### Forms and Functions

Whenever your code starts to look ugly or repetative, it is likely
that you need to create a function to help out. In the example above
we can make a function for creating squares.

```haskell
box color = filled color (square 40)

main =
  collage 400 400
    [ move (100,100) (box red)
    , scale 2 (box green)
    , rotate (degrees 45) (box blue)
    ]
```

This example is a lot nicer to read already! As we learn more about Elm,
we will see ways to make this code look even nicer.

### Elements as Forms

We have this very flexible collage for moving, rotating, and scaling things,
and we do not want to leave elements out. It is safe to do these transformations
on elements as long as they live in the wild-west of forms where there is no
easy stacking.

```haskell
main = collage 400 400 [ toForm (asText 42) ]
```

The `toForm` function will convert any element into a form. From there, we can move
it around however we want!

```haskell
main =
  collage 400 400
   [ move (30,30) (toForm (image 19 21 "/imgs/skull/red.gif"))
   , move (-30,0) (toForm (image 19 21 "/imgs/skull/blue.gif"))
   , move (0,-50) (toForm (image 19 21 "/imgs/skull/red.gif"))
   ]
```

But we are repeating ourselves again. Let&rsquo;s factor out some common code into
a function.

```haskell
skull color position =
  move position
    (toForm (image 19 21 ("/imgs/skull/" ++ color ++ ".gif")))

main = collage 400 400
         [ skull "red"  (30,30)
         , skull "blue" (-30,0)
         , skull "red"  (0,-50)
         ]
```

Note that not just any color will work in this case, we have to have
an image for it and we currently only have red and blue.

### Documentation

That was a lot of new stuff! To help you remember you can look at all
of the documentation for Elm [here][docs]. Each entry there is called a
*module*. The ones we used today are the
[Element](http://package.elm-lang.org/packages/elm-lang/core/latest/Graphics-Element) and
[Collage](http://package.elm-lang.org/packages/elm-lang/core/latest/Graphics-Collage) libraries.
Documentation can be hard to read and takes some getting used to, but
being able to read and understand this kind of document is very important
for quickly learning new things.

[docs]: http://package.elm-lang.org/packages/elm-lang/core/latest

# Practice Problems

These problems will challenge you to use the functions and concepts from
this class, hopefully making graphics easier to use.

 1. Find portraits of three people you find interesting.
    Show all three images, flowing from left to right.

 2. Take the three portraits from problem 1, and add the appropriate name
    beneath each one. It should start to look a bit like a row in a yearbook.

 3. Draw a circle, rectangle, and triangle. Choose the best colors.

 4. Draw a circle, rectangle, and triangle. Label each shape with
    their [perimeter](http://en.wikipedia.org/wiki/Perimeter).

 5. Starting with [this example](/edit/examples/Intermediate/Clock.elm),
    tweak the size and aesthetics until you end up with a nice clock.

 6. Starting with [this example](/edit/examples/Intermediate/Physics.elm),
    change the orbit of the Earth. Part of programming is working with code
    that you do not understand entirely. Do not be afraid!

"""
