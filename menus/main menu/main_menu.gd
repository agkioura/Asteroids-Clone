extends CanvasLayer

@onready var startButton: Button = $VBoxContainer/startButton
@onready var settingsButton: Button = $VBoxContainer/settingsButton
@onready var quitButton: Button = $VBoxContainer/quitButton

func _ready() -> void:
	startButton.pressed.connect(_on_start_pressed)
	settingsButton.pressed.connect(_on_settings_pressed)
	quitButton.pressed.connect(_on_quit_pressed)

func _on_start_pressed() -> void:
	Global.game.loadLevel()
	queue_free()
	
func _on_settings_pressed() -> void:
	Global.game.loadGui("res://menus/settings menu/settings_menu.tscn")
	queue_free()
	
func _on_quit_pressed() -> void:
	get_tree().quit()
