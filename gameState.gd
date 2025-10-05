class_name GameState extends Resource

const SAVEPATH := "res://save.tres"
@export var bestTime: float

func saveGame(_bestTime: float) -> void:
	self.bestTime = _bestTime
	ResourceSaver.save(self, SAVEPATH)
	
static func loadGame() -> Resource:
	if ResourceLoader.exists(SAVEPATH):
		return load(SAVEPATH)
	return null
