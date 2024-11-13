using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ToggleHurtShader : MonoBehaviour
{
    [SerializeField]
    Material NormalMaterial;
    [SerializeField]
    Material HurtMaterial;

    public Renderer meshRenderer;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.Space))
        {
            meshRenderer.material = HurtMaterial;

        }
        else if (Input.GetKeyUp(KeyCode.Space)) 
        {
            meshRenderer.material = NormalMaterial;
        }
    }



}
