class_name NPC extends CharacterBody2D

@onready var dialogueBox: DialogueBox = get_node("../../../CanvasLayer/Game UI/MarginContainer/DialogueBox")
@export var npcSpeed: int = 100
var pathData: PathFollow2D

func _ready():
	pathData = get_parent()
	CustomSignals.promptNPC.connect(_on_prompted)

func _physics_process(delta):
	pathData.progress += npcSpeed * delta

func _on_prompted():
	print("Interaction Received")
	dialogueBox.visible = true
	dialogueBox.proceed_dialogue()
	
