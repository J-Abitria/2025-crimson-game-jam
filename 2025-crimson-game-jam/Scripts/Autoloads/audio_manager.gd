## Manages music in-game
extends Node

var music_player: AudioStreamPlayer
var theme_player: AudioStreamPlayer
var effect_player: AudioStreamPlayer

var music_vol: int
var sfx_vol: int

var music_on = true
var sfx_on = true

var tracks: Dictionary[int, AudioStreamOggVorbis] = {
	1: preload("res://Assets/Music/dating_dubstep.ogg"),
	2: preload("res://Assets/Music/frog_rave.ogg"),
	3: preload("res://Assets/Music/dating_elevator.ogg")
}

var choice_effects: Dictionary[String, AudioStreamOggVorbis] = {
	"happy": preload("res://Assets/SFX/happy.ogg"),
	"angry": preload("res://Assets/SFX/angry.ogg")
}

func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	theme_player = AudioStreamPlayer.new()
	effect_player = AudioStreamPlayer.new()
	self.add_child(music_player)
	self.add_child(theme_player)
	self.add_child(effect_player)
	
	music_vol = -15
	sfx_vol = -8
	
	theme_player.volume_db = sfx_vol
	music_player.volume_db = music_vol

func play_track(track_index: int) -> void:
	if tracks.has(track_index):
		music_player.stream = tracks[track_index]
		music_player.play()
		if not music_on:
			music_player.stream_paused = true

func play_theme(theme: AudioStreamOggVorbis) -> void:
	# turn down music
	if sfx_on:
		var tween := create_tween()
		tween.tween_property(music_player, "volume_db", music_vol - 20, 0.5)
		await tween.finished
		theme_player.stream = theme
		theme_player.play()
		await theme_player.finished
		# turn up music
		tween = create_tween()
		tween.tween_property(music_player, "volume_db", music_vol, 1)

func play_choice_effect(effect: String) -> void:
	if (sfx_on):
		var tween := create_tween()
		tween.tween_property(music_player, "volume_db", music_vol - 20, 0.2)
		if choice_effects.has(effect):
			effect_player.stream = choice_effects[effect]
			effect_player.play()
			await effect_player.finished
		tween = create_tween()
		tween.tween_property(music_player, "volume_db", music_vol, 1)

func pause_track() -> void:
	music_player.stream_paused = true

func resume_track() -> void:
	music_player.stream_paused = false
