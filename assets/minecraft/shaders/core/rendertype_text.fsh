#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in float depthLevel;
in vec4 vertexColor;
in vec2 texCoord0;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
	
	if (color.a < 0.1) {
		discard;
	}
	
	vec3 shadow = vec3(0.248, 0.248, 0.248);
	
	//remove shadow from all non-chat/non-hover text
	if (depthLevel == 0 && lessThan(vertexColor.rgb,shadow) == bvec3(true)) {
		discard;
	}
	
	//remove shadow from chat text
	//if (depthLevel == 100) {
	//	discard;
	//}
	
	//remove shadow from hover text
	//if (depthLevel == 400) {
	//	discard;
	//}
	
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
