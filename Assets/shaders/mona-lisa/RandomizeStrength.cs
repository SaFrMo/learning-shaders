using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RandomizeStrength : MonoBehaviour {

    Renderer r;
    private void Start()
    {
        r = GetComponent<Renderer>();
    }

    private void OnMouseDown()
    {
        r.material.SetFloat("_WobbleIntensity", Random.Range(0, 0.5f));
    }
}
