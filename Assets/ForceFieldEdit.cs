using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ForceFieldEdit : MonoBehaviour
{
    [SerializeField] private Material _mat;
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        _mat.SetVector("_Position", transform.position);
    }

}