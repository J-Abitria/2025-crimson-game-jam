class_name ResponseDialogue extends DialogueType

enum RESPONSE_TYPES {
	COMPLIMENTED,
	QUESTIONED,
	INSULTED
}

## String is the response and the int corresponds to the impact on the jealousy meter
@export var responses: Dictionary[RESPONSE_TYPES, ResponseOption]
