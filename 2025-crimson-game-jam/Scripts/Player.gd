class_name Player extends CharacterBody2D

@export var speed: int = 400
var screenSize

func _ready():
	screenSize = get_viewport_rect().size

func _physics_process(delta):
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
