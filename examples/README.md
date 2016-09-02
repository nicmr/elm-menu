# Examples

There are multiple examples for you to explore in the `./src` directory.

## Pick one to build

#### WAI-ARIA Accessible Example

Autocomplete based on Github mentions CSS: `./src/SimpleExample.elm`

To build: `make accessible`

#### Sections Example

Autocomplete with sections

To build: `make sections`

#### Mentions Example [WIP]

A textarea with controlled autocompletes inside: `./src/MentionsExample.elm`

To build: `make mentions`

Or, any of these without `make`:

`elm make --output build/elm.js src/<some_example.elm>`

## Run it

After building one of these, except the mentions example, simply open `example.html` in your favorite browser!

Open `mention-example.html` in your browser to run the mentions example.
