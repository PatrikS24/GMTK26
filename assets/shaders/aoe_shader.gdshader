shader_type canvas_item;

uniform float pulse_speed = 0.1;
uniform float frequency = 20.0;

void fragment() {
    // Convert atlas UV back to a local 0.0 - 1.0 range
    vec2 local_uv = (UV - REGION_RECT.xy) / REGION_RECT.zw;

    float len = length(local_uv - vec2(0.5, 0.5));
	float mask = clamp(1.0 - length(local_uv - vec2(0.5)) * 2.0, 0.0, 1.0);
	float wave = sin((len * frequency - TIME * pulse_speed) * 20.0);

	mask = mask * (1.0 - len);
    COLOR = mix(vec4(0.0), vec4(wave, wave, wave, 0.5), mask);
}
