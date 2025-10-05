extends Node

var game: Game
var player: SpaceShip
var paused: bool = false

var settings = {
	"windowMode": DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
}

signal gameOver

var arrow = load("res://assets/sprite_0.png")

func _ready() -> void:
	DisplayServer.window_set_mode(settings.windowMode)
	Input.set_custom_mouse_cursor(arrow)
	
func changeWindowSize(size: int) -> void:
	settings.windowMode = size
	DisplayServer.window_set_mode(settings.windowMode)
