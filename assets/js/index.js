import * as THREE from 'three';

const EffectsRegistry = {
    basic: (scene, camera, opts, state) => {
        const geo = new THREE.BoxGeometry(1, 1, 1);
        const mat = new THREE.MeshNormalMaterial();
        const mesh = new THREE.Mesh(geo, mat);
        scene.add(mesh);

        return () => {
            // Logic using the mouse state
            mesh.rotation.x += (state.mouse.y * 0.5 - mesh.rotation.x) * 0.05;
            mesh.rotation.y += (state.mouse.x * 0.5 - mesh.rotation.y) * 0.05;
        };
    },

    starfield: (scene, camera, opts, state) => {
        const starCount = opts.count || 6000;
        const starColor = opts.color || 0xffffff;

        // 1. Create geometry for thousands of points
        const geometry = new THREE.BufferGeometry();
        const positions = new Float32Array(starCount * 3);

        for (let i = 0; i < starCount * 3; i++) {
            // Randomize positions in a large cube
            positions[i] = (Math.random() - 0.5) * 100;
        }

        geometry.setAttribute('position', new THREE.BufferAttribute(positions, 3));

        // 2. Use PointsMaterial for performance (renders as small squares/circles)
        const material = new THREE.PointsMaterial({
            color: starColor,
            size: 0.1,
            transparent: true,
            opacity: 0.8
        });

        const stars = new THREE.Points(geometry, material);
        scene.add(stars);

        // 3. Return the update loop
        return () => {
            // Slow constant rotation
            stars.rotation.y += 0.0005;

            // REACTIVE: Drift the stars based on mouse position
            // We target a slight offset to create a "parallax" feel
            stars.position.x += (state.mouse.x * 2 - stars.position.x) * 0.02;
            stars.position.y += (state.mouse.y * 2 - stars.position.y) * 0.02;
        };
    }
};

export const LiveThreeHook = {
    mounted() {
        const { effect, options } = this.el.dataset;

        // 1. Initialize State & Core Objects
        this.state = { mouse: { x: 0, y: 0 } };
        this.setupScene();

        // 2. Initialize the Effect
        const initEffect = EffectsRegistry[effect] || EffectsRegistry.basic;
        this.updateEffect = initEffect(this.scene, this.camera, JSON.parse(options), this.state);

        // 3. Attach Listeners
        this.addEventListeners();

        // 4. Start Animation
        this.animate();
    },

    // --- Logic Grouping ---

    setupScene() {
        const container = this.el;
        this.scene = new THREE.Scene();
        this.camera = new THREE.PerspectiveCamera(
            75,
            container.offsetWidth / container.offsetHeight,
            0.1,
            1000
        );
        this.camera.position.z = 5;

        this.renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
        this.renderer.setSize(container.offsetWidth, container.offsetHeight);
        container.appendChild(this.renderer.domElement);
    },

    animate() {
        this.animationFrame = requestAnimationFrame(() => this.animate());
        if (this.updateEffect) this.updateEffect();
        this.renderer.render(this.scene, this.camera);
    },

    // --- Event Handlers ---

    addEventListeners() {
        // We bind these to 'this' so they have access to the hook's context
        this.onMouseMove = this.handleMouseMove.bind(this);
        this.onResize = this.handleResize.bind(this);

        window.addEventListener("mousemove", this.onMouseMove);
        window.addEventListener("resize", this.onResize);
    },

    handleMouseMove(e) {
        const rect = this.el.getBoundingClientRect();
        this.state.mouse.x = ((e.clientX - rect.left) / rect.width) * 2 - 1;
        this.state.mouse.y = -((e.clientY - rect.top) / rect.height) * 2 + 1;
    },

    handleResize() {
        const container = this.el;
        this.camera.aspect = container.offsetWidth / container.offsetHeight;
        this.camera.updateProjectionMatrix();
        this.renderer.setSize(container.offsetWidth, container.offsetHeight);
    },

    destroyed() {
        // Clean up using the references we created
        window.removeEventListener("mousemove", this.onMouseMove);
        window.removeEventListener("resize", this.onResize);

        cancelAnimationFrame(this.animationFrame);
        this.renderer.dispose();

        // Optional: Clear geometry/materials from memory
        this.scene.clear();
    }
};