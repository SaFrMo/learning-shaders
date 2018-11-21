Shader "Custom/mona-lisa" {
	Properties {
		_MainTex ("Main Texture", 2D) = "white" {}
		_WobbleStrength ("Wobble Strength Mask", 2D) = "white" {}
		_WobbleSpeed ("Wobble Speed", Range(-5, 5)) = 1
		_WobbleIntensity ("Wobble Intensity", Range(0, .5)) = 0.05
	}
	SubShader {

		CGPROGRAM
// Upgrade NOTE: excluded shader from DX11, OpenGL ES 2.0 because it uses unsized arrays
#pragma exclude_renderers d3d11 gles
		#pragma surface surf Standard fullforwardshadows vertex:vert
		#pragma target 3.0
		#include "noise2d.cginc"

		sampler2D _MainTex;
		sampler2D _WobbleStrength;
		half _WobbleSpeed;
		half _WobbleIntensity;
        
        int _PointCount = 1000;
        float4 _ReversePoints[1000];

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
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            
            // reverse if needed
            for (int i = 0; i < _PointCount; i++){
                float2 p = _ReversePoints[i].xy;
                if (distance(IN.uv_MainTex, p) < 0.1) {
                    c = fixed4(1.0, 1.0, 1.0, 1.0) - c;
                    i = _PointCount;
                }
            }
			o.Albedo = c;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
