LiveThree operates on a "Hybrid State" model.
The Data Flow

- Elixir State: Your LiveView manages high-level data (e.g., score, theme_color).

- The Bridge: Data is passed via the options attribute in the <.three_scene /> component.

- JS State: The Hook receives this data and initializes the Three.js scene.

The Loop: A local requestAnimationFrame loop runs at 60fps, reading from a local state object (containing mouse coordinates) without ever hitting the server.

Lifecycle Management

- Mounted: The Hook initializes the WebGL renderer and attaches window listeners.

- Updated: If the options attribute changes in Elixir, the Hook pushes those changes to the 3D scene.

- Destroyed: Crucially, the Hook disposes of geometries, textures, and listeners to prevent memory leaks during LiveView navigation.