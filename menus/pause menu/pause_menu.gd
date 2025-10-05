extends CanvasLayer

@onready var settingsButton: Button = $VBoxContainer/HBoxContainer/settingsButton
@onready var return_to_title_button: Button = $VBoxContainer/HBoxContainer/returnToTitleButton

func _ready() -> void:
	Global.paused = true
	get_tree().paused = true
	settingsButton.pressed.connect(_on_settings_pressed)
	return_to_title_button.pressed.connect(_on_return_pressed)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Global.paused = false
		get_tree().paused = false
		queue_free()

func _on_settings_pressed() -> void:
	Global.game.loadGui("res://menus/settings menu/settings_menu.tscn")
	
func _on_return_pressed() -> void:
	Global.gameOver.emit()
	get_tree().paused = false
