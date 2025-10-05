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

func _on_back_pressed() -> void:
	Global.game.loadGui("res://menus/main menu/mainMenu.tscn")
	queue_free()

func _on_window_changed(index: int) -> void:
	match index:
		0:
			Global.changeWindowSize(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		1:
			Global.changeWindowSize(DisplayServer.WINDOW_MODE_WINDOWED)
