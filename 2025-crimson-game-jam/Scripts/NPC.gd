class_name NPC extends CharacterBody2D

@onready var dialogueBox: DialogueBox = get_node("../../../CanvasLayer/Game UI/MarginContainer/DialogueBox")
@export var npcSpeed: int = 100
var jealousyLevel: int
var pathData: PathFollow2D

func _ready():
	pathData = get_parent()
	CustomSignals.promptNPC.connect(_on_prompted)
	jealousyLevel = 0
	jealousyDecay()

func _physics_process(delta):
	pathData.progress += npcSpeed * delta

func _on_prompted():
	print("Interaction Received")
	dialogueBox.visible = true
	dialogueBox.proceed_dialogue()

func jealousyDecay():
	while jealousyLevel != 10:
		await get_tree().create_timer(15).timeout
		jealousyLevel += 1
		print("Jealousy Level: %d" % [jealousyLevel])
	print("L romantic partner")
