## Contains all dialogue displayed for one conversation
class_name DialogueState extends Resource

@export var dialogue: Array[DialogueType]
var current_index: int = 0

# Need to load responses from playerData somewhere in here or in dialogue box
func get_next() -> DialogueType:
	var index: int = current_index
	current_index += 1
	if index < dialogue.size():
		if dialogue[index] is ResponseDialogue:
			dialogue[index].responses[ResponseDialogue.RESPONSE_TYPES.COMPLIMENTED] = PlayerData.get_random_compliment()
			dialogue[index].responses[ResponseDialogue.RESPONSE_TYPES.QUESTIONED] = PlayerData.get_random_question()
			dialogue[index].responses[ResponseDialogue.RESPONSE_TYPES.INSULTED] = PlayerData.get_random_insult()
		return dialogue[index]
	else:
		return null

func reset() -> void:
	current_index = 0
