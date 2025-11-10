class_name Player extends CharacterBody2D

signal finished_interaction()

@export var dialogueBox: DialogueBox
@export var speed: int = 400
@export var sprite: AnimatedSprite2D
var interactionHitbox: InteractionHitbox
var heldDrink: String = ""
var heldItem: String = ""
var isInteracting: bool

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
	velocity = Vector2.ZERO
	
	if not isInteracting:
		if Input.is_action_pressed("moveRight"):
			velocity.x += 1
			sprite.play("walk_left")
			sprite.flip_h = true
		if Input.is_action_pressed("moveLeft"):
			velocity.x -= 1
			sprite.play("walk_left")
			sprite.flip_h = false
		if Input.is_action_pressed("moveDown"):
			velocity.y += 1
			sprite.play("walk_down")
		if Input.is_action_pressed("moveUp"):
			velocity.y -= 1
			sprite.play("walk_up")

		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			move_and_slide()
		
		updateInteractionPosition()

func _on_enter_interaction():
	isInteracting = true

func _on_leave_interaction():
	print("DONE INTERACTING")
	isInteracting = false
