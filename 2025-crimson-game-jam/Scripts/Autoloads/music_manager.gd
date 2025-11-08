## Manages music in-game
extends Node

var music_player: AudioStreamPlayer
var theme_player: AudioStreamPlayer

#preload music file
var tracks: Dictionary[int, AudioStreamOggVorbis] = {
	1: preload("res://Assets/Music/DatingDubstep.ogg")
}

var themes: Dictionary[String, AudioStreamOggVorbis] = {
	#"pizza_man": preload("res://832483__harrisonlace__synth_bass_loop_acid_funk_cmin_140.wav")
}

func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	theme_player = AudioStreamPlayer.new()
	self.add_child(music_player)
	self.add_child(theme_player)

func play_track(track_index: int) -> void:
	if tracks.has(track_index):
		music_player.stream = tracks[track_index]
		music_player.play()

func play_theme(character_name: String) -> void:
	# turn down music
	var tween := create_tween()
	tween.tween_property(music_player, "volume_db", -10, 1)
	await tween.finished
	if themes.has(character_name):
		theme_player.stream = themes[character_name]
		theme_player.play()
	await theme_player.finished
	# turn up music
	tween = create_tween()
	tween.tween_property(music_player, "volume_db", 0, 1)

func pause_track() -> void:
	self.stream_paused = true

func resume_track() -> void:
	self.stream_paused = false
