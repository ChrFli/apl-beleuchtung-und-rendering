shader_type spatial;

uniform sampler2D skin_texture; // The texture of your mesh's skin

void fragment() {
    // Use UV coordinates of the mesh, which are fixed to the mesh itself
    vec2 uv = UV;

    // Apply transformations to UV for movement effect
    vec2 transformed_uv = uv * 2.0 - 1.0; // Normalize UVs
    transformed_uv += vec2(sin(TIME * 0.5), cos(TIME * 0.5)) * 0.1; // Add time-based movement

    // Sample the skin texture
    vec4 skin_color = texture(skin_texture, uv);

    // Initialize position and direction
    vec3 pos = vec3(transformed_uv * 0.7, TIME * 2.0); // Use UV for spatial positioning
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

    // Final color blending with the skin texture
    vec3 dynamic_color = vec3(0.1, 0.5, 1.0) * c + vec3(0.0, 0.1, 0.1) * (1.0 - c);
    vec3 final_color = mix(skin_color.rgb, dynamic_color, 0.5); // Blend skin with dynamic color

    // Assign the final color to ALBEDO
    ALBEDO = final_color;

    // Linear interpolation for transparency
}
