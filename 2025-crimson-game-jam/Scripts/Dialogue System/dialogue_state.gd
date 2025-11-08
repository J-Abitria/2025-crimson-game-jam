## Contains all dialogue displayed for one conversation
class_name DialogueState extends Resource

@export var dialogue: Array[DialogueType]
@export var transition_state_index: int
var current_dialogue_index: int = 0

func get_next() -> DialogueType:
	if current_dialogue_index < dialogue.size():
		current_dialogue_index += 1
		return dialogue[current_dialogue_index - 1]
	else:
		current_dialogue_index = 0
		return null
