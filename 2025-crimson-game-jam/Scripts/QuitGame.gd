extends Button

func _ready():
	self.button_down.connect(_on_confirm_quit)

func _on_confirm_quit():
	get_tree().quit()
