class_name LineOfSight extends Area2D

@export var npc: NPC
var timer = 5.0

func _ready():
	npc.direction_change.connect(Callable(self, "detect_change"))

func _process(_delta):
	var overlappingBodies = get_overlapping_bodies()
	
	if timer >= 5.0:
		for body in overlappingBodies:
			if body is Player:
				if body.heldDrink != "":
					print("The player is currently holding a %s" % [body.heldDrink])
				if body.heldItem != "":
					print("The player is currently holding a %s" % [body.heldItem])
				if !npc.isInteracting and body.isInteracting:
					npc.change_love(-20)
				break
	else:
		if (timer <= 0):
			timer = 5
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
