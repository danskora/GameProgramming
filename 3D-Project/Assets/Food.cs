using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Food : MonoBehaviour
{
    float _rotationSpeed = 180f;

    [SerializeField] GameObject _parentQuiz;
    [SerializeField] RuntimeData _runtimeData;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {

    }

    void OnMouseEnter()
    {
        transform.Find("Spot Light").gameObject.SetActive(true);
        _runtimeData.CurrentFoodMousedOver = name;
    }

    private void OnMouseOver()
    {
        transform.Rotate(Vector3.up, _rotationSpeed * Time.deltaTime);

    }

    void OnMouseExit()
    {
        transform.Find("Spot Light").gameObject.SetActive(false);
        _runtimeData.CurrentFoodMousedOver = "";
    }

    void OnMouseDown()
    {
        if (_runtimeData.CurrentGameplayState == GameplayState.FreeWalk)
        {
            StartCoroutine(_parentQuiz.GetComponent<FoodQuiz>().FoodSelected(gameObject));
            _runtimeData.CurrentFoodMousedOver = "";
        }

    }
}
