using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FoodQuiz : MonoBehaviour
{
    [SerializeField] Dialogue _dialogue;
    [SerializeField] Dialogue _correctChoiceDialogue;
    [SerializeField] Dialogue _incorrectChoiceDialogue;

    [SerializeField] GameObject _correctFood;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void OnTriggerEnter()
    {
        GameEvents.InvokeDialogueInitiated(_dialogue);
    }

    public IEnumerator FoodSelected(GameObject food)
    {
        yield return new WaitForEndOfFrame();


        if (food == _correctFood)
        {
            GameEvents.InvokeDialogueInitiated(_correctChoiceDialogue);
        }
        else
        {
            GameEvents.InvokeDialogueInitiated(_incorrectChoiceDialogue);
        }

        Destroy(food);
    }

}
