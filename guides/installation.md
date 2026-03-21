Getting LiveThree running in your Phoenix project takes less than two minutes. Follow these steps to bridge your LiveView to the 3D world.
1. Add the Hex Dependency

Add live_three to your mix.exs file:

```elixir
def deps do
  [
    {:live_three, "~> 0.1.0"}
  ]
end
```

Run `mix deps.get` to fetch the library.

2. Run the Automated Installer

LiveThree includes a Mix task to handle the JavaScript setup for you. This task detects your package manager (npm, yarn, or pnpm) and installs the necessary peer dependencies.

```bash
mix live_three.install
```

3. Register the Hook

Open your assets/js/app.js file. You need to import the LiveThreeHook and include it in your LiveSocket configuration.

```javascript
// assets/js/app.js
import * as THREE from 'three';
import { LiveThreeHook } from "live_three"

// Important: Initialize the hook with the THREE instance
// This makes sure that only one instance of THREE is used across all components
LiveThreeHook.init(THREE);

// Define your hooks object
let Hooks = {
  LiveThreeHook: LiveThreeHook.Hook
}

// Add hooks to your LiveSocket
let liveSocket = new LiveSocket("/live", Socket, {
  params: {_csrf_token: csrfToken},
  hooks: Hooks
})

liveSocket.connect()
```

4. Verify the Setup

To confirm everything is working, drop a basic scene into one of your LiveView templates (.heex):

```elixir
<div class="h-64 w-full">
  <.three_scene id="test-scene" effect="basic" />
</div>
```

If you see a rotating 3D cube, you're ready to go!

Manual Installation (Optional)

If you prefer not to use the Mix task, you can set up the JavaScript manually:

- Install Three.js: `cd assets && npm install three`

- Import via Node Modules: In your app.js, the hook is exported directly from the package. Ensure your build tool (Esbuild/Vite) is configured to resolve Phoenix path dependencies (standard in modern Phoenix apps).

Troubleshooting

- Canvas is invisible: Ensure the parent container of <.three_scene /> has a defined height (e.g., h-screen or h-96). By default, the canvas expands to fill its parent.

- Three.js not found: If your build fails, verify that three appears in your assets/package.json dependencies.