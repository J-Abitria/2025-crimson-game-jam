extends Node

var player_choices: PlayerChoices = preload("res://Resources/player_choices.tres")

func get_random_compliment() -> ResponseOption:
	return player_choices.compliments.pick_random()

func get_random_question() -> ResponseOption:
	return player_choices.questions.pick_random()

func get_random_insult() -> ResponseOption:
	return player_choices.insults.pick_random()
