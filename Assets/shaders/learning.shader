Shader "Custom/learning" {
	Properties {
        _Albedo ("Albedo", Range(0,1)) = 1.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
        #pragma surface surf Lambert
        struct Input {
            float4 color: COLOR;
        };
        
        half _Albedo;
        
        void surf(Input IN, inout SurfaceOutput o) {
            o.Albedo = _Albedo;
        }
        ENDCG
	}
	FallBack "Diffuse"
}
