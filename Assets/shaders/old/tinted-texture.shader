Shader "Custom/Learning" {
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _TintColor ("Tint Color", Color) = (1, 1, 1, 1)
    }

    SubShader {
        Tags { }
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        fixed4 _TintColor;

        struct Input {
            float2 uv_MainTex;
            float4 screenPos;
        };

        void surf(Input IN, inout SurfaceOutput o){
            // (0, 0) to (1, 1) screen space
            float2 coords = IN.screenPos.xy / IN.screenPos.w;
            // strength of tint
            float d = pow(1 - distance(half2(0.5, 0.5), coords), 3);
            // tinted texture
            fixed4 tintedTex = tex2D(_MainTex, IN.uv_MainTex) * _TintColor;
            // lerp from main texture to tinted version
            o.Albedo = lerp( tex2D(_MainTex, IN.uv_MainTex), tintedTex, d) ;
        }
        ENDCG
    }
}
