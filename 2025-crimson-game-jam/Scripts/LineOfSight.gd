class_name LineOfSight extends Area2D

const max_timer = 5.0

@export var npc: NPC
var timer = max_timer

func _ready():
	npc.direction_change.connect(Callable(self, "detect_change"))

func _process(_delta):
	var overlappingBodies = get_overlapping_bodies()
	
	if timer >= max_timer:
		for body in overlappingBodies:
			if body is Player:
				if body.heldDrink != "":
					print("The player is currently holding a %s" % [body.heldDrink])
				if body.heldItem != "":
					print("The player is currently holding a %s" % [body.heldItem])
				if !npc.isInteracting and body.isInteracting:
					npc.change_love(-20)
					AudioManager.play_choice_effect("angry")
					npc.miniPortraitBox.get_node("Minus").visible = true
					for target: NPC in GameData.NPCs.values():
						print("State 2")
						if target.isInteracting:
							npc.miniPortraitBox.visible = true
							npc.miniPortraitBox.get_node("PanelContainer/EnemyNPCPortrait").texture = target.npc_data.get_angry()
					timer -= 1	
			break
	else:
		if (timer <= 0):
			timer = max_timer
			npc.miniPortraitBox.get_node("Minus").visible = false
			npc.miniPortraitBox.visible = false
		else:
			timer -= _delta

func detect_change(direction : Vector2i) :
	if (direction.x == 1):
		rotation = PI/2
	elif (direction.x == -1):
		rotation = 3 * PI/2
	elif (direction.y == -1):
		rotation = PI
	elif(direction.y == 1):
		rotation = 0
