To create a unique look, you can add your own functions to the EffectsRegistry.
Defining an Effect

In your app.js (or a separate file imported there):

```javascript
import { EffectsRegistry } from "live_three"
import * as THREE from "three"

EffectsRegistry.myCustomEffect = (scene, camera, opts, state) => {
  // 1. Initial Setup
  const geometry = new THREE.TorusKnotGeometry(1, 0.3, 100, 16);
  const material = new THREE.MeshNormalMaterial();
  const mesh = new THREE.Mesh(geometry, material);
  scene.add(mesh);

  // 2. Return the Update Loop
  return () => {
    // Access mouse state: state.mouse.x / state.mouse.y
    mesh.rotation.x += 0.01 + (state.mouse.y * 0.05);
    mesh.rotation.y += 0.01 + (state.mouse.x * 0.05);
  };
};
```

Implementation

Call your new effect from any .heex template:

```elixir
<.three_scene id="hero-mesh" effect="myCustomEffect" />
```