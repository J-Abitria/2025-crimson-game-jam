## Contains all of the text for one character
class_name DialogueSystem extends Resource

enum NPC_STATES {
	HATED,
	NEUTRAL,
	LOVED,
	COOLDOWN,
	INTRO
}

enum QUESTION_TYPE {
	ENEMY,
	ITEM,
	DRINK,
	DEFAULT
}

@export var dialogue_states: Dictionary[NPC_STATES, DialogueState]
@export var compliment_responses: Array[DisplayDialogue]
@export var question_responses: Dictionary[QUESTION_TYPE, DisplayDialogue]
@export var insult_responses: Array[DisplayDialogue]
@export var current_state: NPC_STATES

func initialize(npc: NPC) -> void:
	for type: QUESTION_TYPE in question_responses.keys():
		if type == QUESTION_TYPE.ENEMY:
			var enemy = GameData.get_random_npc()
			if GameData.NPCs.size() > 1:
				while enemy.name == npc.name:
					enemy = GameData.get_random_npc()
			question_responses[QUESTION_TYPE.ENEMY].text = question_responses[QUESTION_TYPE.ENEMY].text.format({"npc": enemy.name})
			npc.enemy = enemy

func get_next() -> DialogueType:
	var next_dialogue: DialogueType = dialogue_states[current_state].get_next()
	if next_dialogue:
		return next_dialogue
	else:
		dialogue_states[current_state].reset()
		return null
