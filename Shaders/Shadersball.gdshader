shader_type spatial;

uniform float iTime;
uniform vec2 iResolution;

mat2 r2d(float a) {
    float c = cos(a);
    float s = sin(a);
    return mat2(vec2(c, s), vec2(-s, c));
}

float de(vec3 p) {
    p.y += cos(TIME * 2.0) * 0.2;
    p.xy *= r2d(TIME + p.z);


    vec3 r;
    float d = 0.0, s = 1.0;

    for (int i = 0; i < 3; i++) {
        r = max(r = abs(mod(p * s + 1.0, 2.0) - 1.0), r.yzx);
        d = max(d, (0.9 - min(r.x, min(r.y, r.z))) / s);
        s *= 3.0;
    }

    return d;
}

void fragment() {
    vec2 uv = FRAGCOORD.xy / VIEWPORT_SIZE.xy - 0.5;
    uv.x *= VIEWPORT_SIZE.x / VIEWPORT_SIZE.y;

    vec3 ro = vec3(0.1 * cos(iTime), 0.0, -iTime);
    vec3 rd = normalize(vec3(uv, -1.0));
    vec3 p = ro;

    float it = 0.0;
    for (float i = 0.0; i < 1.0; i += 0.01) {
        it = i;
        float d = de(p);
        if (d < 0.0001) break;
        p += rd * d * 0.4;
    }
    it /= 0.4 * sqrt(abs(tan(iTime) + p.x * p.x + p.y * p.y));

    vec3 c = mix(vec3(0.1, 0.1, 0.3), vec3(0.7, 0.1, 0.3), it * sin(p.z));

    EMISSION = c;
}
