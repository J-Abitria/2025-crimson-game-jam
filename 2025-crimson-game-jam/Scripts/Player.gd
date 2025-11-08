class_name Player extends CharacterBody2D

@export var speed: int = 400
var interactionHitbox: Node2D

func _ready():
	interactionHitbox = get_node("InteractionHitbox")
	print("Interaction Hitbox Pos - X: %d Y: %d" % [interactionHitbox.position.x, interactionHitbox.position.y])

func updateInteractionPosition():
	if velocity.x < 0:
		interactionHitbox.position = Vector2(-70, 0)
	elif velocity.x > 0:
		interactionHitbox.position = Vector2(70, 0)
	elif velocity.y < 0:
		interactionHitbox.position = Vector2(0, -70)
	elif velocity.y > 0:
		interactionHitbox.position = Vector2(0, 70)

func _physics_process(_delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("moveRight"):
		velocity.x += 1
	if Input.is_action_pressed("moveLeft"):
		velocity.x -= 1
	if Input.is_action_pressed("moveDown"):
		velocity.y += 1
	if Input.is_action_pressed("moveUp"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		move_and_slide()
	
	updateInteractionPosition()
