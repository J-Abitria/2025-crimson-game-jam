extends Node2D

func _ready() -> void:
	MusicManager.play_track(1)
	await get_tree().create_timer(3).timeout
	MusicManager.play_theme("zelda")
