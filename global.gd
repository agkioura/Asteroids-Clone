extends Node

var game: Game
var gameState: Resource = GameState.new()
var player: SpaceShip
var paused: bool = false
var inSequence: bool = false
var time: float
var bestTime: float
var sfxSlider: float
var musicSlider: float

var settings = {
	"windowMode": DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
}

var saveData = {
	"settings": {
		"windowMode": DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN,
		"sfxValue": sfxSlider,
		"musicValue": musicSlider
	},
	"bestTime": bestTime
}

signal gameOver

var arrow = load("res://assets/sprites/sprite_0.png")

func _ready() -> void:
	var state = gameState.loadGame()

	if state:
		bestTime = state.bestTime
		sfxSlider = state.sfxSliderValue
		musicSlider = state.musicSliderValue
		settings.windowMode = state.windowMode
	else:
		bestTime = 0.0
		sfxSlider = 1
		musicSlider = 1
		settings.windowMode = 4
		
	AudioServer.set_bus_volume_db(1, linear_to_db(Global.musicSlider))
	AudioServer.set_bus_volume_db(2, linear_to_db(Global.sfxSlider))
	
	DisplayServer.window_set_mode(settings.windowMode)
	Input.set_custom_mouse_cursor(arrow)
	
func changeWindowSize(size: int) -> void:
	settings.windowMode = size
	saveData.settings.windowMode = size
	gameState.saveGame(saveData)
	DisplayServer.window_set_mode(settings.windowMode)
	
# time in milliseconds
func getTimeFormat(_time: float) -> String:
	var mins = int(_time / 60.0)
	var seconds = int(fmod(_time, 60.0))
	var displaySeconds = "0" + str(seconds) if seconds < 10 else str(seconds)
	var displayMins = "0" + str(mins) if mins < 10 else str(mins)

	return displayMins + ":" + displaySeconds
