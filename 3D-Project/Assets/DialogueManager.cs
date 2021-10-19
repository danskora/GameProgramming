using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;
using System;

public class DialogueManager : MonoBehaviour
{

    Dialogue _currentDialogue;
    int _currentSlideIndex = 0;
    [SerializeField] RuntimeData _runtimeData;

    void Awake()
    {
        GameEvents.DialogueFinished += OnDialogueFinished;
        GameEvents.DialogueInitiated += OnDialogueInitiated;
    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            if (_currentSlideIndex < _currentDialogue.DialogueSlides.Length - 1)
            {
                _currentSlideIndex++;
                ShowSlide();
            }
            else
            {
                GameEvents.InvokeDialogueFinished();
            }
        }
    }

    void OnDialogueInitiated(object sender, DialogueEventArgs args)
    {
        _currentDialogue = args.dialoguePayload;
        _currentSlideIndex = 0;
        ShowSlide();
        LoadAvatar();
        GetComponent<Canvas>().enabled = true;
    }

    void OnDialogueFinished(object sender, EventArgs args)
    {
        GetComponent<Canvas>().enabled = false;
        _runtimeData.CurrentGameplayState = GameplayState.FreeWalk;
    }

    void ShowSlide()
    {
        GameObject textObj = transform.Find("DialogueText").gameObject;
        TextMeshProUGUI textComponent = textObj.GetComponent<TextMeshProUGUI>();
        textComponent.text = _currentDialogue.DialogueSlides[_currentSlideIndex];
    }

    void LoadAvatar()
    {
        GameObject avatarObj = transform.Find("Avatar").gameObject;
        avatarObj.GetComponent<RawImage>().texture = _currentDialogue.NPCAvatar;
    }
}
