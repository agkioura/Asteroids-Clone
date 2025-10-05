extends CanvasLayer

@onready var return_to_title_button: Button = $Control/VBoxContainer/HBoxContainer/returnToTitleButton
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timeLabel: Label = $Control/VBoxContainer/HBoxContainer2/Label2
@onready var bestTimeLaber: Label = $Control/VBoxContainer/HBoxContainer2/Label3

func _ready() -> void:
	animation_player.play("pop-in")
	return_to_title_button.pressed.connect(_on_return_pressed)
	if Global.time > Global.bestTime:
		Global.bestTime = Global.time
	timeLabel.text = "Time survived: " + Global.time
	bestTimeLaber.text = "Best time: " + Global.bestTime
	
func _on_return_pressed() -> void:
	if !animation_player.is_playing():
		Global.game.reset()
