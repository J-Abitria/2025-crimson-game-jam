class_name LineOfSight extends Area2D

func _ready():
	pass

func _process(_delta):
	var overlappingBodies = get_overlapping_bodies()
	
	for body in overlappingBodies:
		if body is Player:
			if body.heldDrink != "":
				print("The player is currently holding a %s" % [body.heldDrink])
			if body.heldItem != "":
				print("The player is current holding a %s" % [body.heldItem])
			break
