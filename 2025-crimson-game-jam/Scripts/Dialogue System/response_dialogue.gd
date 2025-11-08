class_name ResponseDialogue extends DialogueType

## String is the response and the int corresponds to the impact on the jealousy meter
@export var responses: Array[ResponseOption]

func play(dialogue_box: DialogueBox) -> void:
	dialogue_box.run_response_dialogue(self)
