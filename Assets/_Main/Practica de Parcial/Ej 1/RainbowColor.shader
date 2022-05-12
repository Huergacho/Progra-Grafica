// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RainbowColor"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_CyberSoldier_Diff("CyberSoldier_Diff", 2D) = "white" {}
		_RedTreshHold("RedTreshHold", Float) = 3
		_WhiteTreshHold("WhiteTreshHold", Float) = 3
		_Speed("Speed", Float) = 5
		_Float0("Float 0", Float) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample2;
		uniform float _Speed;
		uniform sampler2D _TextureSample1;
		uniform sampler2D _CyberSoldier_Diff;
		uniform float4 _CyberSoldier_Diff_ST;
		uniform float _WhiteTreshHold;
		uniform float _Float0;
		uniform sampler2D _TextureSample0;
		uniform float _RedTreshHold;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float mulTime25 = _Time.y * _Speed;
			float temp_output_23_0 = sin( mulTime25 );
			float2 temp_cast_0 = ((0.6 + (temp_output_23_0 - -1.0) * (1.0 - 0.6) / (1.0 - -1.0))).xx;
			float2 temp_cast_1 = ((0.4 + (temp_output_23_0 - -1.0) * (0.6 - 0.4) / (1.0 - -1.0))).xx;
			float2 uv_CyberSoldier_Diff = i.uv_texcoord * _CyberSoldier_Diff_ST.xy + _CyberSoldier_Diff_ST.zw;
			float4 tex2DNode3 = tex2D( _CyberSoldier_Diff, uv_CyberSoldier_Diff );
			float4 lerpResult9 = lerp( tex2D( _TextureSample2, temp_cast_0 ) , tex2D( _TextureSample1, temp_cast_1 ) , saturate( ( ( tex2DNode3.b - _WhiteTreshHold ) * _Float0 ) ));
			float2 temp_cast_2 = ((0.0 + (temp_output_23_0 - -1.0) * (0.33 - 0.0) / (1.0 - -1.0))).xx;
			float4 lerpResult19 = lerp( lerpResult9 , tex2D( _TextureSample0, temp_cast_2 ) , saturate( ceil( ( ( tex2DNode3.r - tex2DNode3.g ) - _RedTreshHold ) ) ));
			o.Albedo = ( lerpResult19 * tex2DNode3 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;485;1112;514;2246.607;645.5899;1.3;False;False
Node;AmplifyShaderEditor.RangedFloatNode;24;-1684.689,-149.547;Inherit;False;Property;_Speed;Speed;6;0;Create;True;0;0;0;False;0;False;5;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1253.753,1038.371;Inherit;False;Property;_WhiteTreshHold;WhiteTreshHold;5;0;Create;True;0;0;0;False;0;False;3;0.29;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-1414.703,147.8809;Inherit;True;Property;_CyberSoldier_Diff;CyberSoldier_Diff;3;0;Create;True;0;0;0;False;0;False;-1;1fb1c364a3eed724bb16168fbb1cad8d;1fb1c364a3eed724bb16168fbb1cad8d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;25;-1626.288,-299.147;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;12;-951.2595,762.6577;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-633.6652,1161.939;Inherit;False;Property;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;0.5;3.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;23;-1128.966,-525.2194;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-692.335,454.599;Inherit;False;Property;_RedTreshHold;RedTreshHold;4;0;Create;True;0;0;0;False;0;False;3;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;6;-1014.02,319.3619;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;39;-461.3487,323.5179;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-538.5018,935.2759;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;46;-655.3093,-76.68978;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.6;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;44;-629.4388,-296.4264;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.4;False;4;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;20;-302.2676,315.6325;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;42;-636.7103,-496.593;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.33;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;45;-322.1564,-315.1125;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;0;False;0;False;-1;None;bb47b838a0905154496dfe9920ae73b0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;47;-348.0269,-95.37588;Inherit;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;0;False;0;False;-1;None;bb47b838a0905154496dfe9920ae73b0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;38;271.3253,960.598;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;9;365.0381,322.7227;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-294.3074,-525.7898;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;bb47b838a0905154496dfe9920ae73b0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;37;-146.8769,310.8923;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;19;531.673,-278.3149;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;1020.559,58.9748;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1409.326,-117.1716;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;RainbowColor;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;25;0;24;0
WireConnection;12;0;3;3
WireConnection;12;1;10;0
WireConnection;23;0;25;0
WireConnection;6;0;3;1
WireConnection;6;1;3;2
WireConnection;39;0;6;0
WireConnection;39;1;8;0
WireConnection;35;0;12;0
WireConnection;35;1;36;0
WireConnection;46;0;23;0
WireConnection;44;0;23;0
WireConnection;20;0;39;0
WireConnection;42;0;23;0
WireConnection;45;1;44;0
WireConnection;47;1;46;0
WireConnection;38;0;35;0
WireConnection;9;0;47;0
WireConnection;9;1;45;0
WireConnection;9;2;38;0
WireConnection;1;1;42;0
WireConnection;37;0;20;0
WireConnection;19;0;9;0
WireConnection;19;1;1;0
WireConnection;19;2;37;0
WireConnection;50;0;19;0
WireConnection;50;1;3;0
WireConnection;0;0;50;0
ASEEND*/
//CHKSM=7ED53CE53EDDFA0FC37A938B39EF111D03DFB54B