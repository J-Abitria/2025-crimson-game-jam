## Contains all of the text for one character
class_name DialogueSystem extends Resource

enum NPC_STATES {
	HATED,
	NEUTRAL,
	LOVED,
	COOLDOWN,
	INTRO
}

@export var dialogue_states: Dictionary[NPC_STATES, DialogueState]
@export var compliment_responses: Array[DisplayDialogue]
@export var question_responses: Array[DisplayDialogue]
@export var insult_responses: Array[DisplayDialogue]
@export var current_state: NPC_STATES

func get_next() -> DialogueType:
	var next_dialogue: DialogueType = dialogue_states[current_state].get_next()
	if next_dialogue:
		return next_dialogue
	else:
		dialogue_states[current_state].reset()
		return null
