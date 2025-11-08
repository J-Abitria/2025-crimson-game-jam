class_name InteractionHitbox extends Area2D

var isEnabled: bool

func enable():
	isEnabled = true

func disable():
	isEnabled = false

func _ready():
	isEnabled = false

func _physics_process(_delta):
	if isEnabled:
		var overlappingBodies = get_overlapping_bodies()
		
		if overlappingBodies.size() > 0:
			for body in overlappingBodies:
				if body is NPC:
					CustomSignals.promptNPC.emit()
					disable()
					break
