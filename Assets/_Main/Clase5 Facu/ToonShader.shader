// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ToonShader"
{
	Properties
	{
		_Step1("Step 1", Range( 0 , 1)) = 1
		_Step2("Step 2", Range( 0 , 1)) = 1
		_Step3("Step 3", Range( 0 , 1)) = 1
		_Step2Intensity("Step2 Intensity", Range( 0 , 1)) = 1
		_Step3Intensity("Step3 Intensity", Range( 0 , 1)) = 1
		_ShadowIntensity("Shadow Intensity", Range( 0 , 1)) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_HatchingFax("HatchingFax", 2D) = "white" {}
		_Min("Min", Range( 0 , 1)) = 0.3043811
		_HatchingTIling("HatchingTIling", Range( 0 , 1)) = 0
		_Max("Max", Range( 0 , 1)) = 1
		_LightAttenuation("LightAttenuation", Range( 0 , 1)) = 0
		_HatchingIntensity("HatchingIntensity", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			float3 worldPos;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _Step1;
		uniform float _Step2;
		uniform float _Step2Intensity;
		uniform float _Step3;
		uniform float _Step3Intensity;
		uniform float _ShadowIntensity;
		uniform float _LightAttenuation;
		uniform float _Min;
		uniform float _Max;
		uniform sampler2D _HatchingFax;
		uniform float _HatchingTIling;
		uniform float _HatchingIntensity;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult6 = dot( ase_worldNormal , ase_worldlightDir );
			float temp_output_7_0 = (dotResult6*0.5 + 0.5);
			float temp_output_19_0 = ( ( 1.0 - step( temp_output_7_0 , _Step1 ) ) + saturate( ( ( 1.0 - step( temp_output_7_0 , _Step2 ) ) - _Step2Intensity ) ) + saturate( ( ( 1.0 - step( temp_output_7_0 , _Step3 ) ) - _Step3Intensity ) ) );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float smoothstepResult34 = smoothstep( _Min , _Max , temp_output_7_0);
			float2 temp_cast_1 = (_HatchingTIling).xx;
			float2 uv_TexCoord41 = i.uv_texcoord * temp_cast_1;
			c.rgb = ( saturate( ( tex2D( _TextureSample0, uv_TextureSample0 ) * ( saturate( ( saturate( temp_output_19_0 ) + ( ceil( temp_output_19_0 ) * _ShadowIntensity ) ) ) * ase_lightColor * float4( ase_lightColor.rgb , 0.0 ) * saturate( ( ase_lightAtten + _LightAttenuation ) ) ) ) ) - ( ( 1.0 - smoothstepResult34 ) * tex2D( _HatchingFax, uv_TexCoord41 ) * _HatchingIntensity ) ).rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;637;1465;362;2087.553;-1549.61;1;True;True
Node;AmplifyShaderEditor.WorldNormalVector;2;-2041.969,129.8298;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;9;-2076.189,427.8509;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;8;-1449.732,404.5673;Inherit;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;6;-1801.109,166.9232;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;7;-1228.14,225.2717;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1153.977,1048.664;Inherit;False;Property;_Step3;Step 3;2;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1190.76,749.3434;Inherit;False;Property;_Step2;Step 2;1;0;Create;True;0;0;0;False;0;False;1;0.49;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;13;-834.4308,717.7339;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;21;-797.6477,1017.055;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-621.6971,1148.689;Inherit;False;Property;_Step3Intensity;Step3 Intensity;4;0;Create;True;0;0;0;False;0;False;1;0.49;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-682.6428,474.1942;Inherit;False;Property;_Step1;Step 1;0;0;Create;True;0;0;0;False;0;False;1;0.728;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;22;-573.3372,1011.472;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-658.4802,849.3682;Inherit;False;Property;_Step2Intensity;Step2 Intensity;3;0;Create;True;0;0;0;False;0;False;1;0.832;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;16;-610.1202,712.1518;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;24;-408.3372,982.4724;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;17;-323.1202,702.1518;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;10;-457.543,225.9135;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;12;-130.5786,260.0391;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;18;-134.1202,757.1518;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;25;-97.33714,1056.473;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;226.8409,269.9506;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;701.0433,491.8594;Inherit;False;Property;_ShadowIntensity;Shadow Intensity;5;0;Create;True;0;0;0;False;0;False;0;0.068;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;27;516.3304,369.5197;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;26;653.0433,257.8594;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;46;984.4659,552.5026;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;862.0433,346.8594;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;962.8655,663.5026;Inherit;False;Property;_LightAttenuation;LightAttenuation;11;0;Create;True;0;0;0;False;0;False;0;0.016;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;49;1270.276,616.363;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;1081.914,291.2867;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-1814.045,1792.828;Inherit;False;Property;_HatchingTIling;HatchingTIling;9;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;45;1183.229,415.9289;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SaturateNode;32;1314.914,310.2867;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;50;1432.276,670.363;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2082.042,1467.049;Inherit;False;Property;_Min;Min;8;0;Create;True;0;0;0;False;0;False;0.3043811;0.294;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-2099.73,1570.201;Inherit;False;Property;_Max;Max;10;0;Create;True;0;0;0;False;0;False;1;0.67;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;33;1087.475,-20.61189;Inherit;True;Property;_TextureSample0;Texture Sample 0;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;1468.968,469.2957;Inherit;False;4;4;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SmoothstepOpNode;34;-1692.811,1497.099;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;-1510.741,1756.895;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;1840.72,522.5172;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;37;-1449.211,1516.506;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-1343.863,1968.847;Inherit;False;Property;_HatchingIntensity;HatchingIntensity;12;0;Create;True;0;0;0;False;0;False;0;0.184;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;39;-1239.978,1624.069;Inherit;True;Property;_HatchingFax;HatchingFax;7;0;Create;True;0;0;0;False;0;False;-1;None;981a0ad040afcd94daf732a3a91960f5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;52;1927.567,284.6994;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-734.5794,1448.909;Inherit;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;54;2316.448,469.9386;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2758.572,157.5872;Float;False;True;-1;6;ASEMaterialInspector;0;0;CustomLighting;ToonShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;2;0
WireConnection;6;1;9;0
WireConnection;7;0;6;0
WireConnection;7;1;8;0
WireConnection;7;2;8;0
WireConnection;13;0;7;0
WireConnection;13;1;14;0
WireConnection;21;0;7;0
WireConnection;21;1;20;0
WireConnection;22;0;21;0
WireConnection;16;0;13;0
WireConnection;24;0;22;0
WireConnection;24;1;23;0
WireConnection;17;0;16;0
WireConnection;17;1;15;0
WireConnection;10;0;7;0
WireConnection;10;1;11;0
WireConnection;12;0;10;0
WireConnection;18;0;17;0
WireConnection;25;0;24;0
WireConnection;19;0;12;0
WireConnection;19;1;18;0
WireConnection;19;2;25;0
WireConnection;27;0;19;0
WireConnection;26;0;19;0
WireConnection;30;0;27;0
WireConnection;30;1;29;0
WireConnection;49;0;46;0
WireConnection;49;1;47;0
WireConnection;31;0;26;0
WireConnection;31;1;30;0
WireConnection;32;0;31;0
WireConnection;50;0;49;0
WireConnection;48;0;32;0
WireConnection;48;1;45;0
WireConnection;48;2;45;1
WireConnection;48;3;50;0
WireConnection;34;0;7;0
WireConnection;34;1;35;0
WireConnection;34;2;36;0
WireConnection;41;0;42;0
WireConnection;51;0;33;0
WireConnection;51;1;48;0
WireConnection;37;0;34;0
WireConnection;39;1;41;0
WireConnection;52;0;51;0
WireConnection;38;0;37;0
WireConnection;38;1;39;0
WireConnection;38;2;53;0
WireConnection;54;0;52;0
WireConnection;54;1;38;0
WireConnection;0;13;54;0
ASEEND*/
//CHKSM=665578949DBCD8889F617381014D8E7E2D7D18BE