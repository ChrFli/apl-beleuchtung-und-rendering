shader_type spatial;

uniform sampler2D texture_albedo;  // Haupttextur
uniform vec2 uv_offset = vec2(10, 10);  // Verschiebung in die obere rechte Ecke
uniform vec2 uv_scale = vec2(10, 10);   // Skalierung, um 1/4 der Textur zu nutzen
uniform vec2 uv_global_scale = vec2(10, 10); // Globale Skalierung zur Anpassung des Modells
uniform float saturation_factor = 2;  // Sättigungsfaktor (im Inspector anpassbar)
uniform float darkness_factor = 0.1;  // Dunkelfaktor (im Inspector anpassbar)

vec3 adjust_saturation(vec3 color, float factor) {
    // Berechnung der Graustufenfarbe
    float gray = dot(color, vec3(0.299, 0.587, 0.114));  
    // Mische zwischen Graustufen und Originalfarbe, um die Sättigung zu erhöhen
    return mix(vec3(gray), color, factor);  
}

void fragment() {
    vec2 uv = UV;
    
    // Spiegelung der X-Koordinate
    uv.x = 0.5 - uv.x;
    
    // Skalierung und Verschiebung anwenden (fokussiert auf den rechten oberen Teil)
    uv = uv * uv_scale + uv_offset;

    // Zusätzliche globale Skalierung anwenden
    uv *= uv_global_scale;

    // Texturfarbe mit finalen UV-Koordinaten abfragen
    vec3 texColor = texture(texture_albedo, uv).rgb;

    // Sättigung anpassen
    texColor = adjust_saturation(texColor, saturation_factor);

    // Helligkeit anpassen (dunkler machen)
    texColor *= darkness_factor;  // Dunkelfaktor anwenden

    // ALBEDO mit der angepassten Farbe setzen
    ALBEDO = texColor;
}