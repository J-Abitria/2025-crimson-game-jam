class_name NPC extends CharacterBody2D

@onready var dialogueBox: DialogueBox = get_node("../../../CanvasLayer/Game UI/MarginContainer/DialogueBox")
@export var npcSpeed: int = 100
var isInteracting: bool
var loveMeter: int
var pathData: PathFollow2D

func _ready():
	pathData = get_parent()
	isInteracting = false
	CustomSignals.promptNPC.connect(_on_prompted)
	dialogueBox.completedDialogue.connect(_on_interaction_complete)
	loveMeter = 50
	loveDecay()

func _physics_process(delta):
	if not isInteracting:
		pathData.progress += npcSpeed * delta

func _on_prompted():
	print("Interaction Received")
	isInteracting = true
	dialogueBox.visible = true
	dialogueBox.proceed_dialogue()

func _on_interaction_complete():
	isInteracting = false

func loveDecay():
	while loveMeter != 0:
		await get_tree().create_timer(5).timeout
		loveMeter -= 1
	print("L romantic partner")
