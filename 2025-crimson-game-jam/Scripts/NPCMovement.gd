class_name NPC extends Node2D

@export var npcSpeed: int = 100
var pathData: PathFollow2D

func _ready():
	pathData = get_node("Path2D/PathFollow2D")

func _process(delta):
	pathData.progress += npcSpeed * delta
