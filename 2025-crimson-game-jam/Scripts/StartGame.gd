extends Button

func _ready():
	self.button_down.connect(_on_confirm_play)

func _on_confirm_play():
	get_tree().change_scene_to_file("res://Scenes/UI/room.tscn")
