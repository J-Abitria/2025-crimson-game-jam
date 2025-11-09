class_name DrinkButton extends Button

@export var drinkValue: int = 1

func _ready():
	toggled.connect(_on_button_pressed)

func _on_button_pressed(newButtonState: bool):
	if newButtonState:
		CustomSignals.drinkRequested.emit(drinkValue)
