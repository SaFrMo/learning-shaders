Shader "Custom/learning" {
	Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _Center ("Center", Vector) = (0,0,0,0)
        _BandInner ("Band Inner", Range(0, 5)) = 0.25
        _BandOuter ("Band Outer", Range(0, 5)) = 0.25
        _Extrusion ("Extrusion", Range(-.01, .01)) = 0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        struct Input {
            float2 uv_MainTex;
            float3 worldPos;
        };
        
        float _Extrusion;
        void vert(inout appdata_full v) {
            v.vertex.xyz += v.normal * _Extrusion;
        }
        
        sampler2D _MainTex;
        float3 _Center;
        float _BandInner;
        float _BandOuter;
        
        void surf(Input IN, inout SurfaceOutput o) {
            float d = distance(_Center, IN.worldPos);
            float tex = tex2D(_MainTex, IN.uv_MainTex);
            
            if (d > _BandInner && d < _BandOuter) {
                o.Albedo = fixed3(1, 0, 0);
            } else {
                o.Albedo = tex;
            }
        }
        ENDCG
	}
	FallBack "Diffuse"
}
