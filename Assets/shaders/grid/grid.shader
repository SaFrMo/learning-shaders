Shader "Custom/grid" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_Width ("Width", int) = 10
		_Height ("Height", int) = 5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		int _Width;
		int _Height;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			/* o.Albedo = c.rgb; */


			// Remapped coordinates method
			fixed2 coordsRaw = IN.uv_MainTex.xy * fixed2((half)_Width, (half)_Height);
			fixed2 coords = fixed2(frac(coordsRaw.x), frac(coordsRaw.y));
			o.Albedo = fixed4(coords.x, coords.y, 0, 1);



			/*
			// Cell index method
			// Cell index, counting from left->right, bottom->top
			// (0, 2) (1, 2) -> 5 6
			// (0, 1) (1, 1) -> 3 4
			// (0, 0) (1, 0) -> 1 2
			int cellIndex = floor(IN.uv_MainTex.x * (half)_Width) + (floor(IN.uv_MainTex.y * _Height) * _Width);

			// lerp from red to blue to show direction
			half progress = (half)cellIndex / ((half)_Width * (half)_Height);
			fixed3 color = lerp(fixed3(1, 0, 0), fixed3(0, 0, 1), progress);
			o.Albedo = fixed4(color, 1);
			*/


			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
