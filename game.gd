class_name Game extends Node2D

var currentScene = null
var currentGui = null

func _ready() -> void:
	Global.game = self
	Global.gameOver.connect(_on_game_over)
	currentScene = load("res://menus/main menu/mainMenu.tscn").instantiate()
	add_child(currentScene)
	
func loadLevel() -> void:
	currentScene = load("res://levels/level.tscn").instantiate()
	add_child(currentScene)
	
func loadGui() -> void:
	currentGui = load("res://ui/health_bar.tscn").instantiate()
	add_child(currentGui)

func _on_game_over() -> void:
	currentScene = load("res://menus/main menu/mainMenu.tscn").instantiate()
	add_child(currentScene)
