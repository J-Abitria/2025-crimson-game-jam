class_name NPC extends CharacterBody2D

enum NPC_MOOD {
	HAPPY,
	NEUTRAL,
	ANGRY
}

signal insulted()

@onready var pathData: PathFollow2D = get_node("..")
@export var sprite: AnimatedSprite2D
var enemy: NPC

@export var npc_data: NPCData
@onready var dialogueBox: DialogueBox = get_node("../../../CanvasLayer/Game UI/MarginContainer/DialogueBox")
@export var npcSpeed: int = 100
var isInteracting: bool
var loveMeter: int
var is_on_cooldown: bool
var current_mood: NPC_MOOD

func _ready():
	GameData.register_npc(self)
	sprite.sprite_frames = npc_data.sprite_sheet
	isInteracting = false
	dialogueBox.completedDialogue.connect(_on_interaction_complete)
	loveMeter = npc_data.starting_love
	update_mood()
	loveDecay()
	
	await get_tree().process_frame
	npc_data.dialogue.initialize(self)

func _physics_process(delta):
	if not isInteracting:
		var previous_position = global_position
		
		pathData.progress += npcSpeed * delta
		
		var movement_step = pathData.global_position - previous_position
		var collision = move_and_collide(movement_step)
		
		if collision:
			pathData.progress -= npcSpeed * delta
			
			var path = pathData.get_parent()
			var attemptedProgress = lerp(pathData.progress, path.curve.get_closest_offset(to_local(global_position)), 0.2)
			
			if attemptedProgress > pathData.progress:
				pathData.progress = attemptedProgress
		
		if pathData.progress > 0.5:
			sprite.play("walk_left")
			sprite.flip_h = true
		else:
			sprite.flip_h = false

func interact() -> void:
	isInteracting = true
	AudioManager.play_theme(npc_data.theme)
	
	dialogueBox.start_dialogue(self)

func start_cooldown() -> void:
	await dialogueBox.completedDialogue
	is_on_cooldown = true
	npc_data.dialogue.current_state = DialogueSystem.NPC_STATES.COOLDOWN
	await get_tree().create_timer(30).timeout
	is_on_cooldown = false
	update_dialogue_state()

func _on_interaction_complete():
	isInteracting = false

func change_love(amount: int) -> void:
	self.loveMeter += amount
	update_mood()

func loveDecay():
	while loveMeter != 0:
		await get_tree().create_timer(5).timeout
		change_love(-1)

func update_mood() -> void:
	if loveMeter >= 70:
		current_mood = NPC_MOOD.HAPPY
	elif loveMeter >= 30:
		current_mood = NPC_MOOD.NEUTRAL
	else:
		current_mood = NPC_MOOD.ANGRY

func update_dialogue_state() -> void:
	match current_mood:
		NPC_MOOD.HAPPY:
			npc_data.dialogue.current_state = DialogueSystem.NPC_STATES.LOVED
		NPC_MOOD.NEUTRAL:
			npc_data.dialogue.current_state = DialogueSystem.NPC_STATES.NEUTRAL
		NPC_MOOD.ANGRY:
			npc_data.dialogue.current_state = DialogueSystem.NPC_STATES.HATED

func enemy_insulted() -> void:
	change_love(30)

func insult() -> void:
	insulted.emit()
