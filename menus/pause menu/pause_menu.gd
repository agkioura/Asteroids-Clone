extends CanvasLayer

@onready var settingsButton: Button = $VBoxContainer/HBoxContainer/settingsButton
@onready var return_to_title_button: Button = $VBoxContainer/HBoxContainer/returnToTitleButton
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	Global.paused = true
	get_tree().paused = true
	settingsButton.pressed.connect(_on_settings_pressed)
	settingsButton.mouse_entered.connect(_on_settings_entered)
	return_to_title_button.mouse_entered.connect(_on_return_entered)
	return_to_title_button.pressed.connect(_on_return_pressed)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Global.paused = false
		get_tree().paused = false
		queue_free()

func _on_settings_pressed() -> void:
	Global.game.loadGui("res://menus/settings menu/settings_menu.tscn")
	
func _on_settings_entered() -> void:
	audio_stream_player_2d.play()
	
func _on_return_pressed() -> void:
	Global.game.reset()
	get_tree().paused = false
	
func _on_return_entered() -> void:
	audio_stream_player_2d.play()
