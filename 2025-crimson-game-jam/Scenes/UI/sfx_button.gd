extends CheckButton

func _ready():
	self.toggled.connect(_on_toggle)
	if not AudioManager.sfx_on:
		self.set_pressed(true)
	else:
		self.set_pressed(false)

func _on_toggle(mode):
	if mode:
		AudioManager.sfx_on = false
		AudioManager.theme_player.stop()
		AudioManager.effect_player.stop()
		AudioManager.music_player.volume_db = AudioManager.music_vol
	else:
		AudioManager.sfx_on = true
