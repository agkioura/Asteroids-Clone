class_name Game extends Node2D

var currentScene = null
@onready var gui: Node2D = $Gui

func _ready() -> void:
	Global.game = self
	loadGui("res://menus/main menu/mainMenu.tscn")
	
func loadLevel() -> void:
	currentScene = load("res://levels/level.tscn").instantiate()
	add_child(currentScene)
	
func loadGui(guiPath: String) -> void:
	var newGui = load(guiPath).instantiate()
	if newGui:
		gui.add_child.call_deferred(newGui)

func reset() -> void:
	for ui in gui.get_children():
		ui.queue_free()
	Global.inSequence = false
	currentScene.queue_free()
	loadGui("res://menus/main menu/mainMenu.tscn")
