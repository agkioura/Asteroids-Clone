extends CanvasLayer

@onready var startButton: Button = $Control/VBoxContainer/startButton
@onready var settingsButton: Button = $Control/VBoxContainer/settingsButton
@onready var quitButton: Button = $Control/VBoxContainer/quitButton
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	animation_player.play("pop-in")
	startButton.pressed.connect(_on_start_pressed)
	settingsButton.pressed.connect(_on_settings_pressed)
	quitButton.pressed.connect(_on_quit_pressed)
	
	startButton.mouse_entered.connect(_on_start_entered)
	settingsButton.mouse_entered.connect(_on_settings_entered)
	quitButton.mouse_entered.connect(_on_quit_entered)

func _on_start_pressed() -> void:
	if !animation_player.is_playing():
		Global.game.loadLevel()
		queue_free()
		
func _on_start_entered() -> void:
	if !animation_player.is_playing():
		audio_stream_player_2d.play()
	
func _on_settings_pressed() -> void:
	if !animation_player.is_playing():
		Global.game.loadGui("res://menus/settings menu/settings_menu.tscn")
		
func _on_settings_entered() -> void:
	if !animation_player.is_playing():
		audio_stream_player_2d.play()
	
func _on_quit_pressed() -> void:
	if !animation_player.is_playing():
		get_tree().quit()
		
func _on_quit_entered() -> void:
	if !animation_player.is_playing():
		audio_stream_player_2d.play()
