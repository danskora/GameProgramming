using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class Inventory : MonoBehaviour
{
    [SerializeField] RuntimeData _runtimeData;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        GameObject textObj = transform.Find("Text").gameObject;
        textObj.GetComponent<TextMeshProUGUI>().text = _runtimeData.apples.ToString();
    }
}
