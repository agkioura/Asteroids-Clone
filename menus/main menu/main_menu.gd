extends CanvasLayer

@onready var startButton: Button = $Control/VBoxContainer/startButton
@onready var settingsButton: Button = $Control/VBoxContainer/settingsButton
@onready var quitButton: Button = $Control/VBoxContainer/quitButton
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("pop-in")
	startButton.pressed.connect(_on_start_pressed)
	settingsButton.pressed.connect(_on_settings_pressed)
	quitButton.pressed.connect(_on_quit_pressed)

func _on_start_pressed() -> void:
	if !animation_player.is_playing():
		Global.game.loadLevel()
		queue_free()
	
func _on_settings_pressed() -> void:
	if !animation_player.is_playing():
		Global.game.loadGui("res://menus/settings menu/settings_menu.tscn")
	
func _on_quit_pressed() -> void:
	if !animation_player.is_playing():
		get_tree().quit()
