extends CheckButton

func _ready():
	self.toggled.connect(_on_toggle)
	if not AudioManager.music_on:
		self.set_pressed(true)
	else:
		self.set_pressed(false)

func _on_toggle(mode):
	if mode:
		AudioManager.music_on = false
		AudioManager.pause_track()
	else:
		AudioManager.music_on = true
		AudioManager.resume_track()
