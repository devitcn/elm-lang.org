import Graphics.Element exposing (..)
import Http exposing (..)
import Math.Vector2 exposing (Vec2)
import Math.Vector3 exposing (..)
import Math.Matrix4 exposing (..)
import Time exposing (..)
import WebGL exposing (..)


-- SIGNALS

main : Signal Element
main =
    let texture = loadTexture "/texture/woodCrate.jpg"
    in
        Signal.map perspective angle
          |> Signal.map2 view texture
          |> Signal.map (webgl (400,400))


angle : Signal Float
angle =
    Signal.foldp (\dt theta -> theta + dt / 10000) 0 (fps 25)


-- MESHES

crate : List (Triangle { pos:Vec3, coord:Vec3 })
crate =
    List.concatMap rotatedFace [ (0,0), (90,0), (180,0), (270,0), (0,90), (0,-90) ]


rotatedFace : (Float,Float) -> List (Triangle { pos:Vec3, coord:Vec3 })
rotatedFace (angleX,angleY) =
    let x = makeRotate (degrees angleX) (vec3 1 0 0)
        y = makeRotate (degrees angleY) (vec3 0 1 0)
        t = x `mul` y `mul` makeTranslate (vec3 0 0 1)
    in
        List.map (map (\x -> {x | pos <- transform t x.pos })) face


face : List (Triangle { pos:Vec3, coord:Vec3 })
face =
    let topLeft     = { pos = vec3 -1  1 0, coord = vec3 0 1 0 }
        topRight    = { pos = vec3  1  1 0, coord = vec3 1 1 0 }
        bottomLeft  = { pos = vec3 -1 -1 0, coord = vec3 0 0 0 }
        bottomRight = { pos = vec3  1 -1 0, coord = vec3 1 0 0 }
    in
        [ (topLeft,topRight,bottomLeft)
        , (bottomLeft,topRight,bottomRight)
        ]


-- VIEW

perspective : Float -> Mat4
perspective angle =
    List.foldr1 mul
        [ perspectiveMatrix
        , camera
        , makeRotate (3*angle) (vec3 0 1 0)
        , makeRotate (2*angle) (vec3 1 0 0)
        ]


perspectiveMatrix : Mat4
perspectiveMatrix =
    makePerspective 45 1 0.01 100


camera : Mat4
camera =
    makeLookAt (vec3 0 0 5) (vec3 0 0 0) (vec3 0 1 0)


view : Response Texture -> Mat4 -> List Entity
view response perspective =
    case response of
      Waiting     -> []
      Failure _ _ -> []
      Success tex -> [entity vertexShader fragmentShader crate { crate = tex, perspective = perspective }]


-- SHADERS

vertexShader : Shader { pos:Vec3, coord:Vec3 } { u | perspective:Mat4 } { vcoord:Vec2 }
vertexShader = [glsl|

attribute vec3 pos;
attribute vec3 coord;
uniform mat4 perspective;
varying vec2 vcoord;

void main () {
  gl_Position = perspective * vec4(pos, 1.0);
  vcoord = coord.xy;
}

|]


fragmentShader : Shader {} { u | crate:Texture } { vcoord:Vec2 }
fragmentShader = [glsl|

precision mediump float;
uniform sampler2D crate;
varying vec2 vcoord;

void main () {
  gl_FragColor = texture2D(crate, vcoord);
}

|]
