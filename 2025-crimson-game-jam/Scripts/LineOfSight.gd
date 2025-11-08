class_name LineOfSight extends Area2D

func _ready():
	pass

func _process(_delta):
	var overlappingBodies = get_overlapping_bodies()
	
	for body in overlappingBodies:
		if body is Player:
			print("I see you!")
			break
