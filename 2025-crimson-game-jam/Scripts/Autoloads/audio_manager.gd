## Manages music in-game
extends Node

var music_player: AudioStreamPlayer
var theme_player: AudioStreamPlayer
var effect_player: AudioStreamPlayer

var tracks: Dictionary[int, AudioStreamOggVorbis] = {
	1: preload("res://Assets/Music/dating_dubstep.ogg"),
	2: preload("res://Assets/Music/frog_rave.ogg")
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
	#theme_player.volume_db = -10
	music_player.volume_db = -40

func play_track(track_index: int) -> void:
	if tracks.has(track_index):
		music_player.stream = tracks[track_index]
		music_player.play()

func play_theme(theme: AudioStreamOggVorbis) -> void:
	# turn down music
	var tween := create_tween()
	tween.tween_property(music_player, "volume_db", -55, 0.5)
	await tween.finished
	theme_player.stream = theme
	theme_player.play()
	await theme_player.finished
	# turn up music
	tween = create_tween()
	tween.tween_property(music_player, "volume_db", 0, 1)

func play_choice_effect(effect: String) -> void:
	var tween := create_tween()
	tween.tween_property(music_player, "volume_db", -55, 0.2)
	if choice_effects.has(effect):
		effect_player.stream = choice_effects[effect]
		effect_player.play()
		await effect_player.finished
	tween = create_tween()
	tween.tween_property(music_player, "volume_db", 0, 1)

func pause_track() -> void:
	self.stream_paused = true

func resume_track() -> void:
	self.stream_paused = false
