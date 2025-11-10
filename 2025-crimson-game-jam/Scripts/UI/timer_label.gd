extends Label

@export var time_alloted_minutes: int
var start_time: int

func _ready() -> void:
	start_time = Time.get_ticks_msec()

func _physics_process(_delta: float) -> void:
	var time_elapsed = Time.get_ticks_msec() - start_time
	var time_remaining = time_alloted_minutes * 60000 - time_elapsed
	
	if time_remaining <= 0:
		GameData.preserveFinalScores()
		get_tree().change_scene_to_file("res://Scenes/Ending.tscn")
	
	if (time_remaining / 1000) % 60 < 10:
		text = str(time_remaining / 60000) + ":0"
	else:
		text = str(time_remaining / 60000) + ":"
	text += str((time_remaining / 1000) % 60) + ":" + str(time_remaining % 1000).substr(0,2)
	
