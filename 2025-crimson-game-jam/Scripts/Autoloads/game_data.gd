extends Node

var NPCs: Dictionary[String, NPC]

func _ready() -> void:
	for npc in get_tree().get_nodes_in_group("NPC"):
		NPCs[npc.name] = npc

func register_npc(npc: NPC) -> void:
	NPCs[npc.name] = npc

func get_random_npc() -> NPC:
	return NPCs.values().pick_random()
