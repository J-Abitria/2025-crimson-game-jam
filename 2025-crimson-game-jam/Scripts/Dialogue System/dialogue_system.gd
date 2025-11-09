## Contains all of the text for one character
class_name DialogueSystem extends Resource

enum NPC_STATES {
	HATED,
	DISLIKED,
	NEUTRAL,
	LIKED,
	LOVED,
	COOLDOWN
}

@export var dialogue_states: Dictionary[NPC_STATES, DialogueState]
@export var compliment_responses: Array[DisplayDialogue]
@export var question_responses: Array[DisplayDialogue]
@export var insult_responses: Array[DisplayDialogue]
var current_state_index: int = 0

func get_next() -> DialogueType:
	#if current_state_index < dialogue_states.size():
		print("printing dialogue from the " + str(current_state_index) + "th state")
		var dialogue_type: DialogueType = dialogue_states[NPC_STATES.NEUTRAL].get_next()
		if dialogue_type is ResponseDialogue:
			for response in dialogue_type.responses.keys():
				match response:
					ResponseDialogue.RESPONSE_TYPES.COMPLIMENTED:
						dialogue_type.responses[ResponseDialogue.RESPONSE_TYPES.COMPLIMENTED] = PlayerData.get_random_compliment()
					ResponseDialogue.RESPONSE_TYPES.QUESTIONED:
						dialogue_type.responses[ResponseDialogue.RESPONSE_TYPES.QUESTIONED] = PlayerData.get_random_question()
					ResponseDialogue.RESPONSE_TYPES.INSULTED:
						dialogue_type.responses[ResponseDialogue.RESPONSE_TYPES.INSULTED] = PlayerData.get_random_insult()
		if !dialogue_type:
			update_state()
		return dialogue_type
	#else:
	#	return null

func update_state() -> void:
	#current_state_index = dialogue_states[current_state_index].transition_state_index
	pass

func set_state(new_state: int) -> void:
	current_state_index = new_state
