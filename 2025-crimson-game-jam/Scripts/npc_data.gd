class_name NPCData extends Resource

@export var theme: AudioStreamOggVorbis
@export var mood_portraits: Dictionary[NPC.NPC_MOOD, CompressedTexture2D]
@export var dialogue: DialogueSystem
@export var starting_love: int
@export var sprite_sheet: SpriteFrames

func get_happy() -> CompressedTexture2D:
	return mood_portraits[NPC.NPC_MOOD.HAPPY]

func get_neutral() -> CompressedTexture2D:
	return mood_portraits[NPC.NPC_MOOD.NEUTRAL]

func get_angry() -> CompressedTexture2D:
	return mood_portraits[NPC.NPC_MOOD.ANGRY]
