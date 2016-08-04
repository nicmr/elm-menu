# Elm Autocomplete

[![Build Status](https://travis-ci.org/thebritican/elm-autocomplete.svg?branch=master)](https://travis-ci.org/thebritican/elm-autocomplete)

> **Note:** A much simpler and more powerful API is fast approaching via [#26](https://github.com/thebritican/elm-autocomplete/issues/26). [I paired with Elm author @evancz](https://twitter.com/czaplic/status/761265397437833216). I'm working on this implementation now!

An Autocomplete component in Elm because typing is hard.

Here's a simple example.

```elm
main =
  let
    updateAutocomplete msg autocomplete =
      let
        ( updatedAutocomplete, status ) = Autocomplete.update msg autocomplete
        -- status communicates extra information the parent on every update
        -- e.g. when the selection changes, the value changes, or the user has triggered a completion
      in
        updatedAutocomplete
  in
    Html.beginnerProgram
      { model = Autocomplete.init [ "elm", "makes", "coding", "life", "easy" ]
      , update = updateAutocomplete
      , view = Autocomplete.view
      }
```

## Demos

Github mention style defaults

![simple-autocomplete-elm](https://cloud.githubusercontent.com/assets/3099999/15311173/ec6c0bfa-1bac-11e6-85e1-b19f30bcdcfe.gif)

Custom styles via CSS classnames. Maybe insert custom HTML for items

![typeahead-elm](https://cloud.githubusercontent.com/assets/3099999/15311152/aacb0746-1bac-11e6-9e2f-b4c30cc90345.gif)

Control autocomplete inside a textarea or contenteditable

![mentions](https://cloud.githubusercontent.com/assets/3099999/15878393/82c18b38-2ccf-11e6-969f-ac1df4bf0f8d.gif)


## Try it out

Find these examples and more in the `./examples` folder.
