using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

public class ClickInteraction : MonoBehaviour {

    Renderer r;
    public Vector2[] points = { new Vector2(0.5f, 0.5f), new Vector2(0.25f, 0.25f) };

    private void Start()
    {
        r = GetComponent<Renderer>();
        UpdatePoints();
    }
    private void Update()
    {
        UpdatePoints();
    }
    private void UpdatePoints()
    {
        r.material.SetInt("_PointCount", points.Length);
        r.material.SetVectorArray("_ReversePoints", points.Select(x => new Vector4(x.x, x.y, 0, 0)).ToArray());
    }
    private void OnMouseDown()
    {


        //r.material.SetFloat("_WobbleIntensity", Random.Range(0, 0.5f));
    }
}
