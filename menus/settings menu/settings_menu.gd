extends CanvasLayer

@onready var windownMode: OptionButton = $VBoxContainer/HBoxContainer/CheckButton
@onready var back_button: Button = $backButton
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sfx_slider: HSlider = $VBoxContainer/Container/HSlider
@onready var music_slider: HSlider = $VBoxContainer/Container2/HSlider

func _ready() -> void:
	windownMode.item_selected.connect(_on_window_changed)
	back_button.pressed.connect(_on_back_pressed)
	back_button.mouse_entered.connect(_on_back_entered)
	
	sfx_slider.value_changed.connect(_on_sfx_value_changed)
	music_slider.value_changed.connect(_on_music_value_changed)
	
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	
	match Global.settings.windowMode:
		DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			windownMode.select(0)
		DisplayServer.WINDOW_MODE_WINDOWED:
			windownMode.select(1)
			
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		queue_free()

func _on_back_pressed() -> void:
	queue_free()
	
func _on_back_entered() -> void:
	audio_stream_player_2d.play()
	
func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	Global.saveData.settings.sfxValue = value
	Global.gameState.saveGame(Global.saveData)

func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	Global.saveData.settings.musicValue = value
	Global.gameState.saveGame(Global.saveData)

func _on_window_changed(index: int) -> void:
	match index:
		0:
			Global.changeWindowSize(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		1:
			Global.changeWindowSize(DisplayServer.WINDOW_MODE_WINDOWED)
