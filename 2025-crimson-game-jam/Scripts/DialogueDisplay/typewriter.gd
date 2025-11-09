class_name Typewriter extends Label

signal finished_typing()

const default_text_speed: float = 0.05
const fast_text_speed: float  = 0.001
var current_text_speed: float
var is_text_done: bool = true

func _ready() -> void:
	current_text_speed = default_text_speed

func play(full_text: String) -> void:
	print("printing")
	is_text_done = false
	text = ""
	for character: String in full_text:
		text += character
		await get_tree().create_timer(current_text_speed).timeout
	is_text_done = true
	finished_typing.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dialogue_click"):
		current_text_speed = fast_text_speed
	elif event.is_action_released("dialogue_click"):
		current_text_speed = default_text_speed
