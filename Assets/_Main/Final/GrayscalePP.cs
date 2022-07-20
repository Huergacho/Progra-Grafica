using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[RequireComponent(typeof(Camera))]
public class GrayscalePP : MonoBehaviour
{
    public Shader shad;

    [Range(0,1)]
    public float intensity;
    public Vector3 position;
    [Range(0, 10)]
    public float fallOff;
    Material mat;


    // Start is called before the first frame update
    void Start()
    {
        mat = new Material(shad);
    }

    // Update is called once per frame
    void Update()
    {
        position = transform.position;
        mat.SetFloat("_Intensity", intensity);
        mat.SetFloat("_FallOff", fallOff);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, mat);
    }
}
