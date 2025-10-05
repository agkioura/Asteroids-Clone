class_name GameState extends Resource

const SAVEPATH := "res://save.tres"
@export var bestTime: float
@export var sfxSliderValue: float
@export var musicSliderValue: float

func saveGame(saveData: Dictionary) -> void:
	self.bestTime = saveData.bestTime
	self.sfxSliderValue = saveData.settings.sfxValue
	self.musicSliderValue = saveData.settings.musicValue
	ResourceSaver.save(self, SAVEPATH)
	
static func loadGame() -> Resource:
	if ResourceLoader.exists(SAVEPATH):
		return load(SAVEPATH)
	return null
