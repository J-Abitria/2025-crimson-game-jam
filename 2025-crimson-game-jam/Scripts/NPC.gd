class_name NPC extends CharacterBody2D

@onready var pathData: PathFollow2D = get_node("../..")
@onready var spriteData: Sprite2D = get_node("Sprite2D")
enum NPC_MOOD {
	HAPPY,
	NEUTRAL,
	ANGRY
}

@export var npc_data: NPCData
@onready var dialogueBox: DialogueBox = get_node("../../../CanvasLayer/Game UI/MarginContainer/DialogueBox")
@export var npcSpeed: int = 100
@export var dialogue_system: DialogueSystem
var isInteracting: bool
var loveMeter: int
var is_on_cooldown: bool
var current_mood: NPC_MOOD

func _ready():
	isInteracting = false
	CustomSignals.promptNPC.connect(_on_prompted)
	dialogueBox.completedDialogue.connect(_on_interaction_complete)
	dialogueBox.modify_love.connect(Callable(self, "change_love"))
	loveMeter = 50
	update_mood()
	loveDecay()

func _physics_process(delta):
	if not isInteracting:
		pathData.progress += npcSpeed * delta
		
		var movementStep = pathData.global_position - global_position
		var collision = move_and_collide(movementStep)
		
		if collision:
			pathData.progress -= npcSpeed * delta
			
			var path = pathData.get_parent()
			var attemptedProgress = lerp(pathData.progress, path.curve.get_closest_offset(to_local(global_position)), 0.2)
			
			if attemptedProgress > pathData.progress:
				pathData.progress = attemptedProgress
		
		if pathData.progress > 0.5:
			spriteData.flip_h = true
		else:
			spriteData.flip_h = false

func _on_prompted():
	print("Interaction Received")
	isInteracting = true
	AudioManager.play_theme(npc_data.theme)
	
	dialogueBox.start_dialogue(self)

func start_cooldown() -> void:
	await dialogueBox.completedDialogue
	npc_data.dialogue.current_state = DialogueSystem.NPC_STATES.COOLDOWN
	await get_tree().create_timer(30).timeout
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
	print("L romantic partner")

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
