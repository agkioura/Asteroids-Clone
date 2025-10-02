extends CanvasLayer

@onready var startButton: Button = $startButton
@onready var quitButton: Button = $quitButton

func _ready() -> void:
	startButton.pressed.connect(_on_start_pressed)
	quitButton.pressed.connect(_on_quit_pressed)

func _on_start_pressed() -> void:
	Global.game.loadLevel()
	queue_free()
	
func _on_quit_pressed() -> void:
	get_tree().quit()
