Shader "Custom/Hurt"
{
    Properties
    {
        //Color of the rim
        _RimColor ("Color", Color) = (0,0.5,0.5,0.0)
        
        //How big the rim is around the hurt character
        _RimPower ("Rim Power", Range(0.5,8.0)) = 7.0
        
        //How much the character wiggles
        _Freq("Frequency", Range(0,5)) = 3
        
        //How fast the character wiggles
        _Speed("Speed", Range(0,500)) = 50
        
        //How big the wiggles are
        _Amp("Amplitude", Range(0,1)) = 0.5
    }
    SubShader
    {
        
        CGPROGRAM
        
        #pragma surface surf Lambert vertex:vert

        struct Input
        {
            float3 viewDir;
            float3 vertColor;
        };

        float4 _RimColor;
        float _RimPower;
        float _Freq;
        float _Speed;
        float _Amp;
        struct appdata
        {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
        };
        void vert (inout appdata v, out Input o)
        {
            UNITY_INITIALIZE_OUTPUT(Input,o);

            //Calculation for how much the wave wiggles
            float t = _Time * _Speed;

            //Calculation for the amount of wiggles
            float waveHeight = sin(t + v.vertex * _Freq) * _Amp + sin(t*2 + v.vertex.x * _Freq) * _Amp;
            v.vertex = v.vertex + waveHeight;
            v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
            o.vertColor = waveHeight + 2;
        }
        void surf (Input IN, inout SurfaceOutput o)
        {
            //Calculation for rim location
            half rim = 1- dot (normalize(IN.viewDir), o.Normal);

            //Calculation for rim emission
            o.Emission = _RimColor.rgb * pow (rim, _RimPower);
        }
        
        ENDCG
    }
    FallBack "Diffuse"
}
