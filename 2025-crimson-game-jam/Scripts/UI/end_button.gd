extends Button

func _ready():
	self.button_down.connect(leave)
	pass

func leave():
	get_tree().change_scene_to_file("res://Scenes/UI/room.tscn")
