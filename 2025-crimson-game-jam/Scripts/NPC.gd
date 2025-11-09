class_name NPC extends CharacterBody2D

@onready var dialogueBox: DialogueBox = get_node("../../../../CanvasLayer/Game UI/MarginContainer/DialogueBox")
@onready var pathData: PathFollow2D = get_node("../..")
@export var npcSpeed: int = 100
@export var dialogue_system: DialogueSystem
var isInteracting: bool
var loveMeter: int

func _ready():
	isInteracting = false
	CustomSignals.promptNPC.connect(_on_prompted)
	dialogueBox.completedDialogue.connect(_on_interaction_complete)
	dialogueBox.change_love.connect(Callable(self, "change_love"))
	loveMeter = 50
	loveDecay()

func _physics_process(delta):
	if not isInteracting:
		pathData.progress += npcSpeed * delta

func _on_prompted():
	print("Interaction Received")
	isInteracting = true
	dialogueBox.visible = true
	dialogueBox.proceed_dialogue()

func _on_interaction_complete():
	isInteracting = false

func change_love(amount: int) -> void:
	self.loveMeter += amount
	print(self.loveMeter)

func loveDecay():
	while loveMeter != 0:
		await get_tree().create_timer(5).timeout
		loveMeter -= 1
	print("L romantic partner")
