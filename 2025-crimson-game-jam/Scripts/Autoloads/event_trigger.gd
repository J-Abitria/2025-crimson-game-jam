# Triggers events that NPCs listen to and determine what conversation to show next
extends Node

signal event(description: String)

func trigger_event(desc: String) -> void:
	event.emit(desc)
