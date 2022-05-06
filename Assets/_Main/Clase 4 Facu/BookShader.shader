// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BookShader"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "black" {}
		_Position("Position", Range( 0 , 5)) = 0
		_Variety("Variety", Range( -1 , 1)) = 0
		_Variety2("Variety2", Range( -1 , 1)) = 0
		_PatternRepetition("Pattern Repetition", Range( 1 , 3)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
		};

		uniform sampler2D _TextureSample0;
		uniform float _Position;
		uniform float _PatternRepetition;
		uniform float _Variety;
		uniform float _Variety2;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float4 color23 = IsGammaSpace() ? float4(0,0.1720123,1,0) : float4(0,0.02504452,1,0);
			float4 color24 = IsGammaSpace() ? float4(1,0.4407697,0,0) : float4(1,0.1632548,0,0);
			float temp_output_40_0 = ( ase_worldPos.x + _Position );
			float2 temp_cast_1 = (temp_output_40_0).xx;
			float simplePerlin2D19 = snoise( temp_cast_1*_PatternRepetition );
			float4 lerpResult22 = lerp( color23 , color24 , step( simplePerlin2D19 , _Variety ));
			float4 color51 = IsGammaSpace() ? float4(0.001112994,0.5566038,0,0) : float4(8.614506E-05,0.2702231,0,0);
			float2 temp_cast_2 = (temp_output_40_0).xx;
			float simplePerlin2D43 = snoise( temp_cast_2*_PatternRepetition );
			float4 lerpResult50 = lerp( lerpResult22 , color51 , step( simplePerlin2D43 , _Variety2 ));
			o.Albedo = ( tex2D( _TextureSample0, (ase_worldPos).xyz.xy ) * saturate( lerpResult50 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;488;1359;511;1788.342;-511.402;1.6;True;True
Node;AmplifyShaderEditor.WorldPosInputsNode;3;-1332.134,113.1755;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;20;-1418.736,455.8482;Inherit;False;Property;_Position;Position;1;0;Create;True;0;0;0;False;0;False;0;3.27;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-1278.185,617.5179;Inherit;False;Property;_PatternRepetition;Pattern Repetition;4;0;Create;True;0;0;0;False;0;False;0;1;1;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-1090.516,340.4229;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-741.7237,800.9259;Inherit;False;Property;_Variety;Variety;2;0;Create;True;0;0;0;False;0;False;0;-1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;19;-822.991,498.2371;Inherit;True;Simplex2D;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;43;-815.8155,937.2838;Inherit;True;Simplex2D;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;23;-426.1054,78.10106;Inherit;False;Constant;_Color1;Color 1;3;0;Create;True;0;0;0;False;0;False;0,0.1720123,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;54;-627.5405,1170.834;Inherit;False;Property;_Variety2;Variety2;3;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;42;-483.2656,503.6458;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;24;-424.8057,247.101;Inherit;False;Constant;_Color2;Color 2;3;0;Create;True;0;0;0;False;0;False;1,0.4407697,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;22;-133.4359,190.9937;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;51;-170.9721,349.3228;Inherit;False;Constant;_Color0;Color 0;4;0;Create;True;0;0;0;False;0;False;0.001112994,0.5566038,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;53;-375.5624,901.6506;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;5;-853.3367,-75.32249;Inherit;False;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;50;110.6732,268.5695;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;15;-640.9355,-115.9586;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;0000000000000000f000000000000000;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;30;89.85677,110.8824;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1168.151,1086.532;Inherit;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;0;False;0;False;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;265.4311,48.97342;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TauNode;31;-1537.239,1084.67;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;427.2696,55.35921;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;BookShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;40;0;3;1
WireConnection;40;1;20;0
WireConnection;19;0;40;0
WireConnection;19;1;41;0
WireConnection;43;0;40;0
WireConnection;43;1;41;0
WireConnection;42;0;19;0
WireConnection;42;1;28;0
WireConnection;22;0;23;0
WireConnection;22;1;24;0
WireConnection;22;2;42;0
WireConnection;53;0;43;0
WireConnection;53;1;54;0
WireConnection;5;0;3;0
WireConnection;50;0;22;0
WireConnection;50;1;51;0
WireConnection;50;2;53;0
WireConnection;15;1;5;0
WireConnection;30;0;50;0
WireConnection;26;0;15;0
WireConnection;26;1;30;0
WireConnection;0;0;26;0
ASEEND*/
//CHKSM=786459AEEF73AEABFFD78487980FA06B0FB4A060