extends Button

func _ready():
	self.button_up.connect(leave)

func leave():
	AudioManager.music_player.stop()
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
