# LiveThree

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `live_three` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:live_three, "~> 0.1.0"}
  ]
end
```

Install Three.js in your assets folder:
```
cd assets && npm install three
```

Register the Hook in assets/js/app.js:
```
import { LiveThreeHook } from "live_three"
let Hooks = { LiveThreeHook }
// ...
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks: Hooks})
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/live_three>.

