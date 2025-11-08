## Contains all of the text for one character
class_name DialogueSystem extends Resource

@export var dialogue_states: Array[DialogueState]
var current_state_index: int = 0

func get_next() -> DialogueType:
	if current_state_index < dialogue_states.size():
		print("printing dialogue from the " + str(current_state_index) + "th state")
		var dialogue_type: DialogueType = dialogue_states[current_state_index].get_next()
		if !dialogue_type:
			update_state()
		return dialogue_type
	else:
		return null

func update_state() -> void:
	current_state_index = dialogue_states[current_state_index].transition_state_index

func set_state(new_state: int) -> void:
	current_state_index = new_state
