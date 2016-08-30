# Elm Autocomplete

[![Build Status](https://travis-ci.org/thebritican/elm-autocomplete.svg?branch=master)](https://travis-ci.org/thebritican/elm-autocomplete)

Autocomplete menus have _just enough_ functionality to be tedious to implement again and again.
This is a flexible library for handling the needs of many different autocompletes.

Your data is stored separately; keep it in whatever shape makes the most sense for your application.
An autocomplete has a lot of uses: form input, mentions, search, etc.

Make an issue if this library cannot handle your scenario and we'll investigate together if it makes sense in the larger
context!

I recommend looking at the [examples](https://github.com/thebritican/elm-autocomplete/tree/master/examples) before diving into the API or source code!

## Examples

Github mention style defaults

![simple-autocomplete-elm](https://cloud.githubusercontent.com/assets/3099999/15311173/ec6c0bfa-1bac-11e6-85e1-b19f30bcdcfe.gif)

Custom styles via CSS classnames. Maybe insert custom HTML for items

![typeahead-elm](https://cloud.githubusercontent.com/assets/3099999/15311152/aacb0746-1bac-11e6-9e2f-b4c30cc90345.gif)

Control autocomplete inside a textarea or contenteditable

![mentions](https://cloud.githubusercontent.com/assets/3099999/15878393/82c18b38-2ccf-11e6-969f-ac1df4bf0f8d.gif)

## Usage Rules

  - Always put `Autocomplete.State` in your model.
  - Never put _any_ `Config` in your model.

Design inspired by [elm-sortable-table](https://github.com/evancz/elm-sortable-table/).

Read about why these usage rules are good rules [here](https://github.com/evancz/elm-sortable-table/tree/1.0.0#usage-rules).

The [API Design Session video](https://www.youtube.com/watch?v=KSuCYUqY058) w/ Evan Czaplicki (@evancz) that brought us to this API.
