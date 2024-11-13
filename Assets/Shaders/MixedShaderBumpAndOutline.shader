Shader "Custom/MixedShaderBumpAndOutline"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Outline ("Outline Width", Range(.002, 0.1)) = .005
        _Bump ("Bump Texture", 2D) = "bump" {}
        _BumpSlider ("Bump Amount", Range(0,5)) = 1
    }
    SubShader
    {
        Tags { "Queue"="Transparent"}
        ZWrite Off

        CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        float _Outline;
        float4 _Color;

        void vert (inout appdata_full v)
        {
            v.vertex.xyz += v.normal *_Outline;            
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Emission = _Color.rgb; 
        }
        ENDCG
        ZWrite On

        CGPROGRAM
        #pragma surface surf Lambert
        sampler2D _Bump;
        half _BumpSlider;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_Bump;
        };

        sampler _MainTex;

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump));
            o.Normal *= float3(_BumpSlider,_BumpSlider,1);

        }


        ENDCG
    }
    FallBack "Diffuse"
}
