class_name DialogueBox extends Control
# connects to static NPC signal that plays dialogue

# get this which will be attached to the NPC
@export var dialogue: DialogueSystem
@export var dialogue_text_label: Typewriter
@export var option_container: Control

func _ready() -> void:
	self.visible = true
	proceed_dialogue()
	# connect to player signal that emits when interacting with an NPC, passes NPC interacted with

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dialogue_click") and dialogue_text_label.is_text_done and visible:
		proceed_dialogue()

func proceed_dialogue() -> void:
	var dialogue_type: DialogueType = dialogue.get_next()
	if dialogue_type:
		dialogue_type.play(self)
	else:
		# if we reach the end of a state (one with no responses), we exit
		exit_dialogue_box()

func run_display_dialogue(display_dialogue: DisplayDialogue) -> void:
	self.dialogue_text_label.play(display_dialogue.text)

func run_response_dialogue(response_dialogue: ResponseDialogue) -> void:
	self.dialogue_text_label.play(response_dialogue.text)
	await self.dialogue_text_label.finished_typing
	for entry in response_dialogue.responses.keys():
		var button: Button = Button.new()
		var callable = Callable(self, "select_response").bind(entry)
		button.text = response_dialogue.responses[entry].response
		button.pressed.connect(callable)
		option_container.add_child(button)
	self.set_process_input(false)

func select_response(choice: ResponseDialogue.RESPONSE_TYPES) -> void:
	for child in self.option_container.get_children():
		child.queue_free()
	match choice:
		ResponseDialogue.RESPONSE_TYPES.COMPLIMENTED:
			self.dialogue_text_label.play(dialogue.compliment_responses.pick_random().text)
		ResponseDialogue.RESPONSE_TYPES.QUESTIONED:
			self.dialogue_text_label.play(dialogue.question_responses.pick_random().text)
		ResponseDialogue.RESPONSE_TYPES.INSULTED:
			self.dialogue_text_label.play(dialogue.insult_responses.pick_random().text)
	self.set_process_input(true)

# Testing mode currently
func exit_dialogue_box() -> void:
	self.visible = false
	# await get_tree().create_timer(1).timeout
	# self.visible = true
	# proceed_dialogue()
