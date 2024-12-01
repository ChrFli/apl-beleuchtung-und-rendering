shader_type spatial;

// Function to simulate the noise
float noise(vec2 pos, float evolve) {
    float e = fract((evolve * 0.015));  // Zeitabhängige Animation
    return fract(sin(dot(pos * e, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    // UV coordinates from the 3D object's texture
    vec2 uv = UV;

    // Generate noise using UV and TIME
    vec3 colour = vec3(noise(uv, TIME));

    // Output the color
    ALBEDO = colour;
}
