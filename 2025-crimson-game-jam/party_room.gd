extends Node2D

@export var canvas: CanvasLayer

func _ready() -> void:
	AudioManager.play_track(1)
	canvas.visible = true
	
