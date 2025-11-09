class_name LineOfSight extends Area2D

@export var npc: NPC

func _ready():
	npc.direction_change.connect(Callable(self, "detect_change"))

func _process(_delta):
	var overlappingBodies = get_overlapping_bodies()
	
	for body in overlappingBodies:
		if body is Player:
			if body.heldDrink != "":
				print("The player is currently holding a %s" % [body.heldDrink])
			if body.heldItem != "":
				print("The player is currently holding a %s" % [body.heldItem])
			break

func detect_change(direction : Vector2i) :
	print(direction.x, ", ", direction.y)
	if (direction.x == 1):
		rotation = PI/2
	elif (direction.x == -1):
		rotation = 3 * PI/2
	elif (direction.y == -1):
		rotation = PI
	elif(direction.y == 1):
		rotation = 0
