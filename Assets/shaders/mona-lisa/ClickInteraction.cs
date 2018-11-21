using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

public class ClickInteraction : MonoBehaviour {

    Renderer r;
    public List<Vector2> points = new List<Vector2>();

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
        r.material.SetVectorArray(
"_ReversePoints",
points.Select(x => new Vector4(x.x, x.y, 0, 0)).PadRight(1000, new Vector4(-1f, -1f, -1f, -1f)).ToArray());

    }
    private void OnMouseDown()
    {
        var ray = Camera.main.ScreenPointToRay(Input.mousePosition);

        RaycastHit hit = new RaycastHit();

        if (Physics.Raycast(ray, out hit))
        {
            if(points.Find(x => x == hit.textureCoord) == default(Vector2)){
                points.Add(hit.textureCoord);
            }
        }


    }
}

public static class ExtensionMethods {
    // https://stackoverflow.com/questions/22152160/linq-fill-function
    public static IEnumerable<T> PadRight<T>(this IEnumerable<T> source, int length, T content = default(T))
    {
        int i = 0;
        // use "Take" in case "length" is smaller than the source's length.
        foreach (var item in source.Take(length))
        {
            yield return item;
            i++;
        }
        for (; i < length; i++)
            yield return content;
    }
}
