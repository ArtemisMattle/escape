shader_type canvas_item;

uniform sampler2D tex;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR *= vec4((vec3(1.3) - texture(tex, mod(UV * vec2(3.0, 9.0), 1.0)).xyz), 1.0);
	COLOR += vec4(vec3(0.8) - texture(tex, mod(UV * vec2(3.0, 9.0) + vec2(1.05, 1.13), 1.0)).xyz, 0) * 0.1;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
