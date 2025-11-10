class_name LineOfSight extends Area2D

const max_timer = 5.0

@export var ray: RayCast2D
@export var npc: NPC
var timer = max_timer
var jealousy_cooldown: int = 10
var can_be_jealous: bool = true

func _ready():
	npc.direction_change.connect(Callable(self, "detect_change"))

func detect_change(direction : Vector2i):
	if (direction.x == 1):
		rotation = PI/2
	elif (direction.x == -1):
		rotation = 3 * PI/2
	elif (direction.y == -1):
		rotation = PI
	elif(direction.y == 1):
		rotation = 0

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.isInteracting and !npc.isInteracting and can_be_jealous:
			AudioManager.play_choice_effect("angry")
			npc.change_love(-10)
			start_cooldown()
			body.dialogueBox.show_portrait(npc, NPC.NPC_MOOD.ANGRY)

func start_cooldown() -> void:
	can_be_jealous = false
	await get_tree().create_timer(jealousy_cooldown).timeout
	can_be_jealous = true
