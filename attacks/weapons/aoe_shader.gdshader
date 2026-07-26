shader_type canvas_item;


void fragment() {

	float len = length(UV - vec2(0.5, 0.5));
	COLOR = vec4(len, len, len, 1.0);
}