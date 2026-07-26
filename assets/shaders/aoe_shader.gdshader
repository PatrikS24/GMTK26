shader_type canvas_item;

void fragment() {
    // Convert atlas UV back to a local 0.0 - 1.0 range
    vec2 local_uv = (UV - REGION_RECT.xy) / REGION_RECT.zw;

    float len = length(local_uv - vec2(0.5, 0.5));
	len = step(len, 0.5);
    COLOR = vec4(len);
}
