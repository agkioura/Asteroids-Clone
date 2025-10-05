class_name GameState extends Resource

const SAVEPATH := "user://save.tres"
@export var bestTime: float
@export var sfxSliderValue: float = 1.0
@export var musicSliderValue: float = 1.0
@export var windowMode: int

func saveGame(saveData: Dictionary) -> void:
	self.bestTime = saveData.bestTime
	self.sfxSliderValue = saveData.settings.sfxValue
	self.musicSliderValue = saveData.settings.musicValue
	self.windowMode = saveData.settings.windowMode
	ResourceSaver.save(self, SAVEPATH)
	
static func loadGame() -> Resource:
	if ResourceLoader.exists(SAVEPATH):
		return load(SAVEPATH)
	return null
