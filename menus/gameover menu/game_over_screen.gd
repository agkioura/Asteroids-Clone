extends CanvasLayer

@onready var return_to_title_button: Button = $Control/VBoxContainer/HBoxContainer/returnToTitleButton
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timeLabel: Label = $Control/VBoxContainer/HBoxContainer2/Label2
@onready var bestTimeLaber: Label = $Control/VBoxContainer/HBoxContainer2/Label3
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	animation_player.play("pop-in")
	return_to_title_button.pressed.connect(_on_return_pressed)
	return_to_title_button.mouse_entered.connect(_on_return_entered)
	if Global.time > Global.bestTime:
		Global.bestTime = Global.time
	timeLabel.text = "Time survived: " + Global.getTimeFormat(Global.time)
	bestTimeLaber.text = "Best time: " + Global.getTimeFormat(Global.bestTime)
	Global.saveData.bestTime = Global.bestTime
	Global.gameState.saveGame(Global.saveData)
	
func _on_return_pressed() -> void:
	if !animation_player.is_playing():
		Global.game.reset()
		
func _on_return_entered() -> void:
	if !animation_player.is_playing():
		audio_stream_player_2d.play()
