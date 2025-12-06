shader_type spatial;

uniform sampler2D texture_x: source_color, repeat_enable;

void fragment() {
	vec4 vertex = INV_VIEW_MATRIX * vec4(VERTEX, 1.0);
	vec3 normal = normalize((INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
	vec3 adjusted_normal = abs(normal);
	vec3 weights = adjusted_normal / (adjusted_normal.x + adjusted_normal.y + adjusted_normal.z) * 3.0;
	
	vec2 uv_x = vertex.zy;
	vec2 uv_y = vertex.xz;
	vec2 uv_z = vertex.xy;

	vec3 color_x = texture(texture_x, uv_x).rbg * weights.x;
	vec3 color_y = texture(texture_x, uv_y).rbg * weights.y;
	vec3 color_z = texture(texture_x, uv_z).rbg * weights.z;

	ALBEDO = (color_x + color_y + color_z)/3.0;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
