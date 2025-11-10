extends Label

func _ready():
	populateLabel()

func populateLabel():
	print("Running populating with %d NPCs" % [GameData.finalScores.size()])
	for i in GameData.finalScores.size():
		self.text += GameData.finalNPCs[i] + "'s Love Meter: " + str(GameData.finalScores[i]) + "\n"
