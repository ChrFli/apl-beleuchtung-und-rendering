shader_type spatial;


void fragment() {
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = UV;

    float c = 0.0, z = 0.0;
    float t = TIME;

   // Loop for complex pattern generation
    for (float f = 0.0; f < 2.0; f += 0.07) {
        z += sin(cos(uv.y * 4.0 * f) + t + f * f) * 1.3 - 2.0;
        c += (0.04 + f * f * 0.001) / distance(uv, vec2(sin(t + f * f + uv.x * z), cos(t - f * f + uv.y * z)));
    }

    // Modify c based on uv and apply transformation
    c -= 0.5 * (1.2 - fract(c + 1.5 + uv.y * 2.5));

    // Conditional transformation of c based on uv.x
    if (uv.x + c * 0.05 < -0.7 || uv.x - c * 0.05 > 0.7)
        c /= 1.6 - mod(uv.x, 0.05) * 14.0 - uv.y * 0.7;

    // Set the final color values
    vec3 color = vec3(c - length(uv) * 0.5, c * 0.7, c * 0.53 - uv.y * 0.15);

    // Assign the final color to the ALBEDO (output color) variable for spatial shaders
    ALBEDO = color;
    // Optional: if you need transparency or other effects, you can use the following:
    // ALPHA = 1.0; // Uncomment if transparency is needed
}

