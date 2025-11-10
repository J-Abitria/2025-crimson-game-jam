extends Node

var NPCs: Dictionary[String, NPC]
var finalNPCs: Array[String] = []
var finalScores: Array[int] = []

func _ready() -> void:
	for npc in get_tree().get_nodes_in_group("NPC"):
		NPCs[npc.name] = npc

func register_npc(npc: NPC) -> void:
	NPCs[npc.name] = npc

func get_random_npc() -> NPC:
	return NPCs.values().pick_random()

func preserveFinalScores():
	var npcList: Array[NPC] = GameData.NPCs.values()
	finalNPCs.resize(npcList.size())
	finalScores.resize(npcList.size())
	
	for i in npcList.size():
		finalNPCs[i] = str(npcList[i].name)
		finalScores[i] = npcList[i].loveMeter
