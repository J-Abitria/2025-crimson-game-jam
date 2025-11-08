class_name DisplayDialogue extends DialogueType

func play(dialogue_box: DialogueBox) -> void:
	dialogue_box.run_display_dialogue(self)
