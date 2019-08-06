# Elm Menu

[![Build Status](https://travis-ci.org/ContaSystemer/elm-menu.svg?branch=master)](https://travis-ci.org/ContaSystemer/elm-menu)

This is a fork of [thebritican/elm-autocomplete](https://github.com/thebritican/elm-autocomplete) because it's not longer maintained.
[Conta Systemer AS](https://contasystemer.no/) is going to maintain it from now on.

> Per discussion in [#37](https://github.com/thebritican/elm-autocomplete/issues/37),
> this library is moved into `elm-menu` (Since it's really just a menu currently).
> The `AccessibleExample` (with a simple API and included `input` field) will be the _mostly_
> drop-in solution for this library. If you want to build more complicated features (like mentions),
> use `elm-menu` after the work is done porting it! Meanwhile, you'll have to copy/paste the example...
> obviously not ideal! The motivation here: no one wants to have 300 lines of boilerplate for the common
> case of a typical form autocomplete!

## Demo

Checkout the [landing page] inspired by [React Autosuggest]'s page design

[landing page]: https://contasystemer.github.io/elm-menu/
[React Autosuggest]: http://react-autosuggest.js.org/

Autocomplete menus have _just enough_ functionality to be tedious to implement again and again.
This is a flexible library for handling the needs of many different autocompletes.

Your data is stored separately; keep it in whatever shape makes the most sense for your application.

Make an issue if this library cannot handle your scenario and we'll investigate together if it makes sense in the larger context!

I recommend looking at the [examples] before diving into the API or source code!

[examples]: https://github.com/ContaSystemer/elm-menu/tree/master/examples

## Usage Rules

  - Always put `Menu.State` in your model.
  - Never put _any_ `Config` in your model.

Design inspired by [elm-sortable-table](https://github.com/evancz/elm-sortable-table/).

Read about why these usage rules are good rules [here](https://github.com/evancz/elm-sortable-table/tree/1.0.0#usage-rules).

The [API Design Session video](https://www.youtube.com/watch?v=KSuCYUqY058) w/ Evan Czaplicki (@evancz) that brought us to this API.


## Installation

```
elm package install ContaSystemer/elm-menu
```

## Setup
```elm
import Menu exposing (input)
import Html

main =
  Browser.sandbox { init = init, update = update, view = view }

type alias Model =
  { autoState : Menu.State -- Own the State of the menu in your model
  , query : String -- Perhaps you want to filter by a string?
  , people : List Person -- The data you want to list and filter
  , howManyToShow : Int
  }

type alias Person =
  { name: String
  }

init : Model
init 
  { autoState = Menu.empty
  , query = ""
  , people = [Person{name = "Jim"}, Person{name = "Leonard"}]
  , howManyToShow = 5
  }

-- Let's filter the data however we want
acceptablePeople : String -> List Person -> List Person
acceptablePeople query people =
  let
      lowerQuery =
          String.toLower query
  in
      List.filter (String.contains lowerQuery << String.toLower << .name) people

-- Set up what will happen with your menu updates
updateConfig : Menu.UpdateConfig Msg Person
updateConfig =
    Menu.updateConfig
        { toId = .name
        , onKeyDown =
            \code maybeId ->
                if code == 13 then
                    Maybe.map SelectPerson maybeId
                else
                    Nothing
        , onTooLow = Nothing
        , onTooHigh = Nothing
        , onMouseEnter = \_ -> Nothing
        , onMouseLeave = \_ -> Nothing
        , onMouseClick = \id -> Just <| SelectPerson id
        , separateSelections = False
        }

type Msg
  = SetAutocompleteState Menu.Msg | SetQuery String

update : Msg -> Model -> Model
update msg model =
  case msg of
    SetAutocompleteState autoMsg ->
      let
        (newState, maybeMsg) =
          Menu.update updateConfig autoMsg model.howManyToShow model.autoState (acceptablePeople model.query model.people)
      in
        { model | autoState = newState }
    SetQuery q ->
      { model | query = q }

-- setup for your autocomplete view
viewConfig : Menu.ViewConfig Person
viewConfig =
  let
    customizedLi keySelected mouseSelected person =
      { attributes = [ classList [ ("autocomplete-item", True), ("is-selected", keySelected || mouseSelected) ] ]
      , children = [ Html.text person.name ]
      }
  in
    Menu.viewConfig
      { toId = .name
      , ul = [ class "autocomplete-list" ] -- set classes for your list
      , li = customizedLi -- given selection states and a person, create some Html!
      }

-- and let's show it! (See an example for the full code snippet)
view : Model -> Html Msg
view model =
  div []
      [ input [ onInput SetQuery ] []
      , Html.map SetAutocompleteState (Menu.view viewConfig model.howManyToShow model.autoState (acceptablePeople model.query model.people))
      ]

```

---

![Conta Systemer AS](https://contasystemer.no/wp-content/themes/contasystemer/images/logo.png)