shader_type canvas_item;

// sky texture
uniform sampler2D noise_texture: repeat_enable, filter_nearest;
// sky density
uniform float density: hint_range(0.0, 1.0) = 0.25;
// sky speed
uniform vec2 speed = vec2(0.02, 0.01);

void fragment() {

	vec2 uv = UV + speed * TIME;

	float noise = texture(noise_texture, uv).r;

	float cloud = clamp(noise * 2.0 - 1.0, 0.0, 1.0);

	COLOR.a *= cloud * density;
}
