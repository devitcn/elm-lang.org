import Char exposing (isDigit)
import Graphics.Element exposing (..)
import Graphics.Input.Field as Field
import String


main : Signal Element
main =
  numbers.signal
    |> Signal.filter isAllDigits Field.noContent
    |> Signal.map display


numbers : Signal.Mailbox Field.Content
numbers =
  Signal.mailbox Field.noContent


display : Field.Content -> Element
display content =
  Field.field Field.defaultStyle (Signal.message numbers.address) "Only numbers!" content


isAllDigits : Field.Content -> Bool
isAllDigits content =
  String.all isDigit content.string