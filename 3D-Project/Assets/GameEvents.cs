using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class DialogueEventArgs : EventArgs
{
    public Dialogue dialoguePayload;
}

public static class GameEvents
{
    public static event EventHandler<DialogueEventArgs> DialogueInitiated;
    public static event EventHandler DialogueFinished;
    public static void InvokeDialogueInitiated(Dialogue dialogue)
    {
        DialogueInitiated(null, new DialogueEventArgs { dialoguePayload = dialogue});
    }

    public static void InvokeDialogueFinished()
    {
        DialogueFinished(null, EventArgs.Empty);
    }
}
