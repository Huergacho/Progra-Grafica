// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SphereMask"
{
	Properties
	{
		_PointPosition("Point Position", Vector) = (0,0,0,0)
		_Radius("Radius", Float) = 1
		_FallOff("FallOff", Float) = 1
		_Position("Position", Vector) = (0,0,0,0)
		_Hight("Hight", Range( 0 , 10)) = 1
		_NearPointColor("NearPoint Color", Color) = (0,0,0,0)
		_FarPointColor("Far Point Color", Color) = (0,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha addshadow fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
		};

		uniform float3 _PointPosition;
		uniform float _Radius;
		uniform float _FallOff;
		uniform float3 _Position;
		uniform float _Hight;
		uniform float4 _NearPointColor;
		uniform float4 _FarPointColor;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_4_0 = distance( _PointPosition , ase_worldPos );
			v.vertex.xyz += ( sin( ( _Time.y + pow( ( temp_output_4_0 / _Radius ) , _FallOff ) ) ) * _Position * _Hight );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float temp_output_4_0 = distance( _PointPosition , ase_worldPos );
			float4 lerpResult29 = lerp( _NearPointColor , _FarPointColor , temp_output_4_0);
			o.Albedo = lerpResult29.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;618;1404;381;1545.872;416.3043;2.349772;True;True
Node;AmplifyShaderEditor.WorldPosInputsNode;2;-983.3226,302.7749;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;1;-1000.068,50.37502;Inherit;False;Property;_PointPosition;Point Position;0;0;Create;True;0;0;0;False;0;False;0,0,0;-2.30536,1.264975,4.600648;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DistanceOpNode;4;-577.3427,119.1289;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-523.5383,405.7585;Inherit;False;Property;_Radius;Radius;1;0;Create;True;0;0;0;False;0;False;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;5;-339.5151,189.3607;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-284.2075,436.8314;Inherit;False;Property;_FallOff;FallOff;2;0;Create;True;0;0;0;False;0;False;1;0.93;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;8;-179.2075,306.8314;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;23;-87.89685,143.0018;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;97.10315,196.0018;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;17;-187.051,604.3358;Inherit;False;Property;_Position;Position;3;0;Create;True;0;0;0;False;0;False;0,0,0;0,0.48,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;19;-117.0544,845.8159;Inherit;False;Property;_Hight;Hight;4;0;Create;True;0;0;0;False;0;False;1;1.8;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;25;278.2822,199.8675;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;28;198.0626,-326.7946;Inherit;False;Property;_NearPointColor;NearPoint Color;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,0.01938601,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;30;145.964,-150.7801;Inherit;False;Property;_FarPointColor;Far Point Color;6;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.09344961,0.1886792,0.1868879,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;363.2913,439.9246;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;29;467.9716,-26.00461;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;816.9747,42.80228;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;SphereMask;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;1;0
WireConnection;4;1;2;0
WireConnection;5;0;4;0
WireConnection;5;1;6;0
WireConnection;8;0;5;0
WireConnection;8;1;9;0
WireConnection;26;0;23;0
WireConnection;26;1;8;0
WireConnection;25;0;26;0
WireConnection;18;0;25;0
WireConnection;18;1;17;0
WireConnection;18;2;19;0
WireConnection;29;0;28;0
WireConnection;29;1;30;0
WireConnection;29;2;4;0
WireConnection;0;0;29;0
WireConnection;0;11;18;0
ASEEND*/
//CHKSM=D3027E3AD115C4124BF667C884CDEDE5AC9B2F5D