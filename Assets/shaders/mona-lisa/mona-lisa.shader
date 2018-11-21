Shader "Custom/mona-lisa" {
	Properties {
		_MainTex ("Main Texture", 2D) = "white" {}
		_WobbleStrength ("Wobble Strength Mask", 2D) = "white" {}
		_WobbleSpeed ("Wobble Speed", Range(-5, 5)) = 1
		_WobbleIntensity ("Wobble Intensity", Range(0, .5)) = 0.05
	}
	SubShader {

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows vertex:vert
		#pragma target 3.0
		#include "noise2d.cginc"

		sampler2D _MainTex;
		sampler2D _WobbleStrength;
		half _WobbleSpeed;
		half _WobbleIntensity;

		struct Input {
			float2 uv_MainTex;
			float2 uv_WobbleStrength;
		};

		void vert (inout appdata_full v, out Input IN) {
			UNITY_INITIALIZE_OUTPUT(Input, IN);
			float noiseX = cnoise((v.vertex.xy + _Time * _WobbleSpeed) ) * _WobbleIntensity;
			float noiseZ = cnoise((v.vertex.xy + 500 + _Time * _WobbleSpeed) ) * _WobbleIntensity;
			float strength = tex2Dlod (_WobbleStrength, float4(v.texcoord.xy, 0, 0)).r;
			v.vertex.x += noiseX * strength;
			v.vertex.z += noiseZ * strength;
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
