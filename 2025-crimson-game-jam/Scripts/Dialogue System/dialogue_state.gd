## Contains all dialogue displayed for one conversation
class_name DialogueState extends Resource

@export var dialogue: Array[DialogueType]
@export var transition_state_index: int
var current_dialogue_index: int = 0

func get_next() -> DialogueType:
	if current_dialogue_index < dialogue.size():
		print("printing the " + str(current_dialogue_index) + "th dialogue string in this state")
		current_dialogue_index += 1
		if dialogue[current_dialogue_index - 1] is ResponseDialogue:
			current_dialogue_index = 0
		return dialogue[current_dialogue_index - 1]
	else:
		current_dialogue_index = 0
		return null
