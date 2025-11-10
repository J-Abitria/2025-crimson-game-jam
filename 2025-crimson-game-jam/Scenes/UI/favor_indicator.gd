class_name FavorIndicator extends PanelContainer

@export var portrait: TextureRect
@export var plus: Sprite2D
@export var minus: Sprite2D

func _ready() -> void:
	self.visible = false

func show_portrait(npc: NPC, mood: NPC.NPC_MOOD) -> void:
	self.visible = true
	portrait.texture = npc.npc_data.mood_portraits[mood]
	match mood:
		NPC.NPC_MOOD.HAPPY:
			plus.visible = true
		NPC.NPC_MOOD.ANGRY:
			minus.visible = true
	await get_tree().create_timer(3).timeout
	self.visible = false
	plus.visible = false
	minus.visible = false
