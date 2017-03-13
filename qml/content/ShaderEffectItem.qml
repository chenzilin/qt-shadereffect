import QtQuick 2.0

ShaderEffect {
	id: shader
	width: 400
	height: 400

	property real viewport_width: width
	property real viewport_height: height

	property real iGlobalTime: 0

	fragmentShader: "

#ifdef GL_ES
precision mediump float;
#endif

uniform float viewport_width;
uniform float viewport_height;
//vec3 iResolution = vec3(viewport_width, viewport_height, 0.0);

uniform float iGlobalTime;
varying highp vec2 qt_TexCoord0;

// **********your sub functions code range upper**********
// **********all .5 , 2. should change to 0.5 , 2.0**********

float noise(vec3 p)
{
	vec3 i = floor(p);
	vec4 a = dot(i, vec3(1.0, 57.0, 21.0)) + vec4(0.0, 57.0, 21.0, 78.0);
	vec3 f = cos((p-i)*acos(-1.0))*(-0.5)+0.5;
	a = mix(sin(cos(a)*a),sin(cos(1.0+a)*(1.0+a)), f.x);
	a.xy = mix(a.xz, a.yw, f.y);
	return mix(a.x, a.y, f.z);
}

float sphere(vec3 p, vec4 spr)
{
	return length(spr.xyz-p) - spr.w;
}

float flame(vec3 p)
{
	float d = sphere(p*vec3(1.0,0.5,1.0), vec4(0.0,-1.0,0.0,1.0));

	vec3 tmpVec3 = p+vec3(0.0,iGlobalTime*2.0,0.0);

	float tmp1 = noise(tmpVec3) + noise(p*3.0)*0.5 ;

	return d + tmp1*0.25*p.y ;

	//return 10.0;
}

float scene(vec3 p)
{
	return min(100.-length(p) , abs(flame(p)) );
}

vec4 raymarch(vec3 org, vec3 dir)

{
	float d = 0.0, glow = 0.0, eps = 0.02;
	vec3  p = org;
	bool glowed = false;

	for(int i=0; i<64; i++)
	{
		d = scene(p) + eps;
		p += d * dir;
		if( d>eps )
		{
			if(flame(p) < 0.0)
				glowed=true;
			if(glowed)
				glow = float(i)/64.0;
		}
	}
	return vec4(p,glow);
}

// **********your sub functions code range below**********

void main()
{
    vec3 iResolution = vec3(viewport_width, viewport_height, 0.0);

    float d_xCoord = qt_TexCoord0.x * iResolution.x;
    float d_yCoord = qt_TexCoord0.y * iResolution.y;

// ^ Y (d_yCoord)
// |
// |
// |
// |   vec4(0.0, 0.0, 0.0, 1.0): black
// |   vec4(1.0, 1.0, 1.0, 1.0): white
// |
// |
// |
// |——————————————————————> X (d_xCoord)
// **********your main function body code range upper**********
// **********change your fragCoord.xy to gl_FragCoord.xy**********
// **********change your fragColor to gl_FragColor**********
// **********all .5 , 2. should change to 0.5 , 2.0**********

	 vec2 v = -1.0 + 2.0 * gl_FragCoord.xy / iResolution.xy;
     v.x *= iResolution.x/iResolution.y;

	 vec3 org = vec3(0.0, -2.0, 4.0);
	 vec3 dir = normalize(vec3(v.x*1.6, -v.y, -1.5));

	 vec4 p = raymarch(org, dir);
	 float glow = p.w;

	 vec4 col = mix(vec4(1.0,0.5,0.1,1.0), vec4(0.1,0.5,1.0,1.0), p.y*0.02+0.4);

	 gl_FragColor = mix(vec4(0.0), col, pow(glow*2.0,4.0));

	//gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);

// **********your main function body code range below**********
}
"
}
