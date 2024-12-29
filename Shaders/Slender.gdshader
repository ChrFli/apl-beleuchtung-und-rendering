shader_type spatial;

uniform sampler2D texture : hint_default_black; // Textur als Uniform
uniform float distortion_strength : hint_range(0.0, 1.0) = 0.2; // Stärke der Verzerrung
uniform float static_intensity : hint_range(0.0, 1.0) = 0.3; // Intensität der TV-Statik
uniform float speed : hint_range(0.1, 5.0) = 1.0; // Geschwindigkeit der TV-Statik

void fragment() {
    // Verzerrung durch zufällige Verschiebung der Texturkoordinaten
    vec2 distorted_uv = UV + vec2(sin(TIME * speed + UV.y * 10.0) * distortion_strength, cos(TIME * speed + UV.x * 10.0) * distortion_strength);

    // Begrenze die verzerrten UV-Koordinaten auf den gültigen Bereich (0 bis 1)
    distorted_uv = mod(distorted_uv, 1.0); // Dies stellt sicher, dass die Koordinaten innerhalb der Textur bleiben

    // TV-Statik: Zufälliges Rauschen basierend auf den Texturkoordinaten
    float noise = fract(sin(dot(distorted_uv, vec2(12.9898, 78.233))) * 43758.5453);
    noise = smoothstep(0.4, 0.6, noise); // Rauschfilterung, um es starker oder schwächer zu machen

    // Holen der Texturfarbe an den verzerrten Koordinaten
    vec3 base_color = texture(texture, distorted_uv).rgb;

    // Kombiniere Verzerrung und TV-Statik
    vec3 static_color = mix(base_color, vec3(noise), static_intensity); // Mische die Statik mit der Textur

    // Setze die Farbe des Pixels
    ALBEDO = static_color;
}

