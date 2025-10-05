extends CanvasLayer

@onready var windownMode: OptionButton = $VBoxContainer/HBoxContainer/CheckButton
@onready var back_button: Button = $VBoxContainer/backButton

func _ready() -> void:
	windownMode.item_selected.connect(_on_window_changed)
	back_button.pressed.connect(_on_back_pressed)
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

func _on_window_changed(index: int) -> void:
	match index:
		0:
			Global.changeWindowSize(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		1:
			Global.changeWindowSize(DisplayServer.WINDOW_MODE_WINDOWED)
