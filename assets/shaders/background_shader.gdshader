shader_type canvas_item;

// Camera & Viewport Inputs
uniform vec2 camera_position;
uniform vec2 viewport_size;
uniform float eye_openness;

// Voronoi
uniform float cell_size : hint_range(1.0, 500.0) = 60.0;
uniform float morph_speed : hint_range(0.0, 10.0) = 0.5;
uniform int detail : hint_range(1, 5) = 3;
uniform float roughness : hint_range(0.0, 1.0) = 0.5;
uniform float lacunarity : hint_range(1.0, 4.0) = 2.0;

// Colors
uniform vec4 edge_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 background_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 perlin_edge_color : source_color = vec4(0.0, 1.0, 0.0, 1.0);
uniform vec4 perlin2_edge_color : source_color = vec4(1.0, 0.0, 1.0, 1.0);

// Textures
uniform sampler2D eyelid_texture : source_color, filter_linear;
uniform sampler2D room_texture : source_color, filter_linear;

// Perlin Controls
uniform float perlin_scale : hint_range(0.1, 50.0) = 5.0;
uniform float perlin_speed : hint_range(0.0, 5.0) = 0.2;
uniform float perlin_threshold : hint_range(0.0, 1.0) = 0.6;
uniform float edge_width : hint_range(0.01, 0.5) = 0.15;

// Second Perlin Controls
uniform float perlin2_scale : hint_range(0.1, 50.0) = 5.0;
uniform float perlin2_speed : hint_range(0.0, 5.0) = 0.2;
uniform float perlin2_threshold : hint_range(0.0, 1.0) = 0.6;


// Hash function for Perlin
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float perlin(vec2 p, float period) {
    vec2 wrapped = mod(p, period);
    vec2 i = floor(wrapped);
    vec2 f = fract(wrapped);
    vec2 u = f * f * (3.0 - 2.0 * f);

    float a = hash(mod(i, period));
    float b = hash(mod(i + vec2(1.0, 0.0), period));
    float c = hash(mod(i + vec2(0.0, 1.0), period));
    float d = hash(mod(i + vec2(1.0, 1.0), period));

    vec2 grad_a = vec2(cos(a * 6.2832), sin(a * 6.2832));
    vec2 grad_b = vec2(cos(b * 6.2832), sin(b * 6.2832));
    vec2 grad_c = vec2(cos(c * 6.2832), sin(c * 6.2832));
    vec2 grad_d = vec2(cos(d * 6.2832), sin(d * 6.2832));

    float dot_a = dot(grad_a, f);
    float dot_b = dot(grad_b, f - vec2(1.0, 0.0));
    float dot_c = dot(grad_c, f - vec2(0.0, 1.0));
    float dot_d = dot(grad_d, f - vec2(1.0, 1.0));

    float result = mix(mix(dot_a, dot_b, u.x), mix(dot_c, dot_d, u.x), u.y);
    return result * 0.5 + 0.5;
}


float fbm(vec2 p, int octaves, float period) {
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;
    float max_value = 0.0;

    for (int i = 0; i < 5; i++) {
        if (i >= octaves) break;
        value += amplitude * perlin(p * frequency, period / frequency);
        max_value += amplitude;
        frequency *= 2.0;
        amplitude *= 0.5;
    }

    return value / max_value;
}

vec3 safe_rand_3d(vec3 p) {
    p = fract(p * vec3(443.8975, 397.2973, 491.1871));
    p += dot(p.xyz, p.yzx + 19.19);
    return fract(vec3(p.x * p.y, p.x * p.z, p.y * p.z));
}

float base_voronoi_layer(vec3 uvw) {
    vec3 i_st = floor(uvw);
    vec3 f_st = fract(uvw);
    float min_dist = 1.0;

    for (int z = -1; z <= 1; z++) {
        for (int y = -1; y <= 1; y++) {
            for (int x = -1; x <= 1; x++) {
                vec3 neighbor = vec3(float(x), float(y), float(z));
                vec3 point = safe_rand_3d(i_st + neighbor);
                point = 0.5 + 0.4 * sin(uvw.z + point * 6.2831);
                vec3 diff = neighbor + point - f_st;
                float dist = length(diff);
                if (dist < min_dist) {
                    min_dist = dist;
                }
            }
        }
    }
    return min_dist;
}


void fragment() {
    // world position
    vec2 world_pixel_pos = (SCREEN_UV * viewport_size) + camera_position;
    vec2 scaled_world_pos = world_pixel_pos / max(cell_size, 0.001);
    float dynamic_time = TIME * morph_speed;
    vec3 coords = vec3(scaled_world_pos.x, scaled_world_pos.y, dynamic_time);

    // Voronoi
    float total_noise = 0.0;
    float amplitude = 1.0;
    float max_possible_amplitude = 0.0;

    for (int i = 0; i < detail; i++) {
        total_noise += base_voronoi_layer(coords) * amplitude;
        max_possible_amplitude += amplitude;
        amplitude *= roughness;
        coords.xy *= lacunarity;
        coords.z *= 1.5;
    }

    float voronoi_mask = clamp(total_noise / max_possible_amplitude, 0.0, 1.0);

    // First perlin layer
float perlin_period = 20.0;

vec2 perlin_uv =
	scaled_world_pos * perlin_scale +
	vec2(TIME * perlin_speed, TIME * perlin_speed * 0.7);

float perlin_value = fbm(perlin_uv, 3, perlin_period);
float perlin_mask = smoothstep(
	perlin_threshold,
	perlin_threshold + 0.2,
	perlin_value
);

// Second perlin layer
vec2 perlin2_uv =
	scaled_world_pos * perlin2_scale +
	vec2(TIME * perlin2_speed, TIME * perlin2_speed * 0.7);

float perlin2_value = fbm(perlin2_uv, 3, perlin_period);
float perlin2_mask = smoothstep(
	perlin2_threshold,
	perlin2_threshold + 0.2,
	perlin2_value
);

// Base voronoi color
vec4 original_color = mix(background_color, edge_color, voronoi_mask);

// Apply first perlin layer
vec4 perlin_color = mix(background_color, perlin_edge_color, voronoi_mask);
vec4 color_after_first = mix(
	original_color,
	perlin_color,
	voronoi_mask * perlin_mask
);

// Apply second perlin layer
vec4 perlin2_color = mix(background_color, perlin2_edge_color, voronoi_mask);
vec4 final_background_color = mix(
	color_after_first,
	perlin2_color,
	voronoi_mask * perlin2_mask
);

// Eye close/open
vec2 uv = SCREEN_UV;

vec2 pivot = vec2(0.5);
uv -= pivot;
float cos_angle = cos(PI);
float sin_angle = sin(PI);
mat2 rotation_matrix = mat2(
    vec2(cos_angle, -sin_angle),
    vec2(sin_angle, cos_angle)
);

// Rotate
vec2 bottom_uv = (rotation_matrix * uv) + pivot + vec2(0.0, -eye_openness);
vec2 top_uv = uv + pivot + vec2(0.0, -eye_openness);
vec2 room_uv = uv + pivot;

vec4 bottom_mask_color = texture(eyelid_texture, bottom_uv);
float bottom_mask = bottom_mask_color.g * bottom_mask_color.a;

vec4 top_mask_color = texture(eyelid_texture, top_uv);
float top_mask = top_mask_color.g * top_mask_color.a;

float background_mask = top_mask + bottom_mask;

vec4 room_texture_color = texture(room_texture, room_uv);

COLOR = mix(room_texture_color, final_background_color, min(background_mask, 1.0));
}