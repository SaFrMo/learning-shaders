Shader "Custom/mona-lisa" {
	Properties {
		_MainTex ("Main Texture", 2D) = "white" {}
		_WobbleSpeed ("Wobble Speed", Range(-5, 5)) = 1
	}
	SubShader {

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows vertex:vert
		#pragma target 3.0
		#include "noise2d.cginc"

		sampler2D _MainTex;
		half _WobbleSpeed;

		struct Input {
			float2 uv_MainTex;
		};

		void vert (inout appdata_full v) {
			float noise = cnoise((v.vertex.xy + _Time * _WobbleSpeed) ) * 0.05;
			v.vertex.xz += noise;
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
