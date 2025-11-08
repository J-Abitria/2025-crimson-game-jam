class_name NPC extends CharacterBody2D

@export var npcSpeed: int = 100
var pathData: PathFollow2D

func _ready():
	pathData = get_node("Path2D/PathFollow2D")
	CustomSignals.promptNPC.connect(_on_prompted)

func _physics_process(delta):
	pathData.progress += npcSpeed * delta

func _on_prompted():
	print("Interaction Received")
