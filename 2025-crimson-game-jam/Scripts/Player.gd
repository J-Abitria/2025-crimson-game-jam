class_name Player extends CharacterBody2D

enum MOVE_DIRECTION { LEFT, RIGHT, UP, DOWN }

@export var speed: int = 400

var currentDirection: MOVE_DIRECTION
var interactionHitbox: Node2D

func _ready():
	currentDirection = MOVE_DIRECTION.UP
	interactionHitbox = get_node("InteractionHitbox")
	print("Interaction Hitbox Pos - X: %d Y: %d" % [interactionHitbox.position.x, interactionHitbox.position.y])

func _input(event):
	if event is InputEventKey and not event.echo and event.is_pressed():
		match event.keycode:
			KEY_W:
				currentDirection = MOVE_DIRECTION.UP
				print("The new direction is up.")
			KEY_A:
				currentDirection = MOVE_DIRECTION.LEFT
				print("The new direction is left.")
			KEY_S:
				currentDirection = MOVE_DIRECTION.DOWN
				print("The new direction is down.")
			KEY_D:
				currentDirection = MOVE_DIRECTION.RIGHT
				print("The new direction is right.")
			_:
				print("No valid direction for this input.")

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
