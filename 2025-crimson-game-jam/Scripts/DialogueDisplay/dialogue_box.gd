class_name DialogueBox extends Control
# connects to static NPC signal that plays dialogue

# get this which will be attached to the NPC
var dialogue: DialogueSystem
var npc: NPC
@export var dialogue_theme: Theme
@export var dialogue_text_label: Typewriter
@export var portrait: TextureRect
@export var option_container: Control
@export var love_meter: ProgressBar
signal completedDialogue()
@export var favor_indicator: FavorIndicator

func _ready() -> void:
	self.visible = false

func start_dialogue(character: NPC) -> void:
	self.dialogue = character.npc_data.dialogue
	self.npc = character
	love_meter.value = npc.loveMeter
	
	update_mood_display()
	
	self.visible = true
	proceed_dialogue()

func _input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("dialogue_click") and dialogue_text_label.is_text_done:
		proceed_dialogue()

func proceed_dialogue() -> void:
	var next_dialogue: DialogueType = dialogue.get_next()
	if next_dialogue:
		if next_dialogue is DisplayDialogue:
			run_display_dialogue(next_dialogue)
		elif next_dialogue is ResponseDialogue:
			run_response_dialogue(next_dialogue)
	else:
		exit_dialogue_box()

func run_display_dialogue(display_dialogue: DisplayDialogue) -> void:
	print("displaying display_dialogue")
	dialogue_text_label.play(display_dialogue.text)

func run_response_dialogue(response_dialogue: ResponseDialogue) -> void:
	print("displaying response_dialogue")
	dialogue_text_label.play(response_dialogue.text)
	await dialogue_text_label.finished_typing
	for response_type: ResponseDialogue.RESPONSE_TYPES in response_dialogue.responses.keys():
		var button: Button = Button.new()
		button.theme = dialogue_theme
		button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		button.text = response_dialogue.responses[response_type].response
		if npc.is_on_cooldown:
			if response_type == ResponseDialogue.RESPONSE_TYPES.QUESTIONED:
				button.pressed.connect(Callable(self, "select_response").bind(response_type))
				option_container.add_child(button)
		else:
			button.pressed.connect(Callable(self, "select_response").bind(response_type))
			option_container.add_child(button)
		set_process_input(false)

func select_response(choice: ResponseDialogue.RESPONSE_TYPES) -> void:
	set_process_input(true)
	for i in option_container.get_children():
		i.queue_free()
	match choice:
		ResponseDialogue.RESPONSE_TYPES.COMPLIMENTED:
			run_display_dialogue(dialogue.compliment_responses.pick_random())
			npc.change_love(25)
			AudioManager.play_choice_effect("happy")
			portrait.texture = npc.npc_data.get_happy()
			npc.start_cooldown()
		ResponseDialogue.RESPONSE_TYPES.QUESTIONED:
			portrait.texture = npc.npc_data.get_neutral()
			var question_type: DialogueSystem.QUESTION_TYPE = dialogue.question_responses.keys().pick_random()
			match question_type:
				DialogueSystem.QUESTION_TYPE.ENEMY:
					if !npc.enemy.insulted.is_connected(Callable(npc, "enemy_insulted")):
						npc.enemy.insulted.connect(Callable(npc, "enemy_insulted"))
			run_display_dialogue(dialogue.question_responses[question_type])
			# when question is answered, get signal to subscribe npc to
		ResponseDialogue.RESPONSE_TYPES.INSULTED:
			run_display_dialogue(dialogue.insult_responses.pick_random())
			npc.change_love(-25)
			AudioManager.play_choice_effect("angry")
			portrait.texture = npc.npc_data.get_angry()
			npc.start_cooldown()
			npc.insult()
	love_meter.value = npc.loveMeter
	update_mood_display()

func update_mood_display() -> void:
	match npc.current_mood:
		NPC.NPC_MOOD.HAPPY:
			portrait.texture = npc.npc_data.get_happy()
			love_meter.modulate = Color.PINK
		NPC.NPC_MOOD.NEUTRAL:
			portrait.texture = npc.npc_data.get_neutral()
			love_meter.modulate = Color.WHITE
		NPC.NPC_MOOD.ANGRY:
			portrait.texture = npc.npc_data.get_angry()
			love_meter.modulate = Color.DARK_RED

func show_portrait(caller: NPC, mood: NPC.NPC_MOOD) -> void:
	favor_indicator.show_portrait(caller, mood)

func exit_dialogue_box() -> void:
	self.visible = false
	completedDialogue.emit()
