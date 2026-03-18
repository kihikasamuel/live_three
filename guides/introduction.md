LiveThree is a bridge between the real-time server-side power of Phoenix LiveView and the high-performance 3D rendering of Three.js.
The Problem

Typically, LiveView and Three.js "fight" over the DOM. LiveView wants to sync HTML state, while Three.js needs a stable, unmutated canvas to run its animation loop.
The Solution

LiveThree uses Phoenix Hooks to creates a protected "sandbox" for Three.js. It provides:

- Zero-Latency Reactivity: Mouse and resize events are handled locally in the browser, keeping your WebSockets clear.
- Declarative Components: Control 3D scenes using standard Elixir function components.
- Extensible Registry: Use built-in effects like starfield or register your own custom JavaScript engines.