shader_type spatial;



void fragment() {
    // Use UV coordinates of the mesh, which are fixed to the mesh itself
    vec2 uv = UV;

    // Normalize UV coordinates (optional, adjust based on your texture setup)
    uv = uv * 2.0 - 1.0;

    // Initialize position and directionr
    vec3 pos = vec3(uv * 0.7, TIME * 2.0); // Use UV for spatial positioning
    vec3 dir = normalize(vec3(pos.xy, 3.0));

    // Offset position for animation
    pos.xy += (3.0 * 3.14159265 / 5.0) * vec2(sin(pos.z * 0.2), cos(pos.z * 0.2)) - vec2(3.14159265 / 2.0, 0.0);

    // Iterative loop for ray marching
    for (int i = 0; i < 164; i++) {
        float d = max(
            abs(sin(pos.x) * cos(pos.y) + sin(pos.y) * cos(pos.z * 0.2) + sin(pos.z * 0.2) * cos(pos.x)) + 0.0001,
            0.0
        );
        pos += dir * d * 2.0;
    }

    // Compute color intensity
    float c = 16.0 / (pos.z - TIME * 2.0 + 16.0);

    // Final color blending
    vec3 color = vec3(0.1, 0.5, 1.0) * c + vec3(0.0, 0.1, 0.1) * (1.0 - c);

    // Assign the final color to ALBEDO
    ALBEDO = color;
}

