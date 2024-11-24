shader_type spatial;

// Function to simulate the noise
float noise(vec2 pos, float evolve) {
    float e = fract((evolve * 0.000001));  // Loop the evolution
    float cx = pos.x * e;
    float cy = pos.y * e;

    // Generate a "random" value
    return fract(23.0 * fract(2.0 / fract(fract(cx * 2.4 / cy * 23.0 + pow(abs(cy / 22.4), 3.3)) * fract(cx * evolve / pow(abs(cy), 0.050)))));
}

void fragment() {
    // UV coordinates from the 3D object's texture
    vec2 uv = UV;

    // Generate noise using UV and TIME
    vec3 colour = vec3(noise(uv, TIME));

    // Output the color
    ALBEDO = colour;
}

// Uncomment if you want to customize lighting behavior for this material
//void light() {
//    ALBEDO = vec3(1.0); // Replace with custom lighting logic if needed
//}
