class_name Player extends CharacterBody2D

signal finished_interaction()

@export var dialogueBox: DialogueBox
@export var speed: int = 400
@export var sprite: AnimatedSprite2D
var interactionHitbox: InteractionHitbox
var heldDrink: String = ""
var heldItem: String = ""
var isInteracting: bool
var last_direction: Vector2

func _ready():
	interactionHitbox = get_node("InteractionHitbox")
	interactionHitbox.visible = false
	isInteracting = false
	if dialogueBox:
		dialogueBox.completedDialogue.connect(_on_leave_interaction)

func updateInteractionPosition():
	if velocity.x < 0:
		interactionHitbox.position = Vector2(-20, 0)
	elif velocity.x > 0:
		interactionHitbox.position = Vector2(20, 0)
	elif velocity.y < 0:
		interactionHitbox.position = Vector2(0, -20)
	elif velocity.y > 0:
		interactionHitbox.position = Vector2(0, 20)

func promptInteraction():
	interactionHitbox.visible = true
	interactionHitbox.enable()
	await get_tree().create_timer(0.1).timeout
	interactionHitbox.visible = false
	interactionHitbox.disable()

func _process(_delta):
	if not isInteracting:
		if Input.is_action_just_pressed("interact"):
			promptInteraction()

func _physics_process(_delta):
	var direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	
	if not isInteracting:
		if direction != Vector2.ZERO:
			velocity = velocity.move_toward(direction * speed, speed / 3)
			last_direction = direction
			if direction.x > 0:
				sprite.play("walk_left")
				sprite.flip_h = true
			elif direction.x < 0:
				sprite.play("walk_left")
				sprite.flip_h = false
			elif direction.y > 0:
				sprite.play("walk_down")
			elif direction.y < 0:
				sprite.play("walk_up")
		else:
			velocity = velocity.move_toward(Vector2.ZERO, speed / 5)
			match last_direction:
				Vector2.RIGHT:
					sprite.play("idle_left")
					sprite.flip_h = true
				Vector2.LEFT:
					sprite.play("idle_left")
					sprite.flip_h = false
				Vector2.DOWN:
					sprite.play("idle_down")
				Vector2.UP:
					sprite.play("idle_up")
		move_and_slide()
		
		updateInteractionPosition()

func _on_enter_interaction():
	isInteracting = true

func _on_leave_interaction():
	print("DONE INTERACTING")
	isInteracting = false
