using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Initializer : MonoBehaviour
{
    [SerializeField] RuntimeData _runtimeData;
    [SerializeField] Dialogue _startingDialogue;
    // Start is called before the first frame update
    void Awake()
    {
        _runtimeData.CurrentFoodMousedOver = "";
        _runtimeData.CurrentGameplayState = GameplayState.InDialogue;
    }

    private void Start()
    {
        GameEvents.InvokeDialogueInitiated(_startingDialogue);
    }
}
