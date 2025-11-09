class_name NPC extends CharacterBody2D

@onready var dialogueBox: DialogueBox = get_node("../../../../CanvasLayer/Game UI/MarginContainer/DialogueBox")
@onready var pathData: PathFollow2D = get_node("../..")
@onready var spriteData: Sprite2D = get_node("Sprite2D")
@export var npcSpeed: int = 100
@export var dialogue_system: DialogueSystem
var isInteracting: bool
var loveMeter: int

func _ready():
	isInteracting = false
	CustomSignals.promptNPC.connect(_on_prompted)
	dialogueBox.completedDialogue.connect(_on_interaction_complete)
	dialogueBox.change_love.connect(Callable(self, "change_love"))
	loveMeter = 50
	loveDecay()

func _physics_process(delta):
	if not isInteracting:
		pathData.progress += npcSpeed * delta
		
		var movementStep = pathData.global_position - global_position
		var collision = move_and_collide(movementStep)
		
		if collision:
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
	dialogueBox.visible = true
	dialogueBox.proceed_dialogue()

func _on_interaction_complete():
	isInteracting = false

func change_love(amount: int) -> void:
	self.loveMeter += amount
	print(self.loveMeter)

func loveDecay():
	while loveMeter != 0:
		await get_tree().create_timer(5).timeout
		loveMeter -= 1
	print("L romantic partner")
