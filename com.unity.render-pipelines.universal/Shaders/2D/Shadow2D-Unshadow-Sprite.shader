Shader "Hidden/Shadow2DUnshadowSprite"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Tint", Color) = (1,1,1,1)
        [HideInInspector] _ShadowColorMask("__ShadowColorMask", Int) = 0
    }
    SubShader
    {
        Tags { "RenderType" = "Transparent" }

        // Rendered the composite shadowed part
        Pass
        {

            // Bit 0: Not Composite Shadows, Bit 1: Global Shadow
            Stencil
            {
                Ref       0
                Comp      Equal  // To be totally correct this needs to be always and we need to have another pass probably for global shadows
                Pass      Keep
                Fail      Keep
            }

            Cull Off
            Blend   One One
            BlendOp RevSub
            ZWrite Off

            ColorMask [_ShadowColorMask]

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Varyings
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4    _MainTex_ST;

            Varyings vert(Attributes v)
            {
                Varyings o;
                o.vertex = TransformObjectToHClip(v.vertex.xyz);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            half4 frag(Varyings i) : SV_Target
            {
                half4 main = tex2D(_MainTex, i.uv);
                return half4(main.a, main.a, main.a, main.a);
            }
            ENDHLSL
        }
    }
}
