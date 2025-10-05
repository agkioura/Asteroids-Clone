extends CanvasLayer

@onready var health: HBoxContainer = $HBoxContainer/MarginContainer/TextureRect/HBoxContainer
@onready var timer: Label = $HBoxContainer/Label
var time: float

var healthPoints: int

func _ready() -> void:
	time = 0.0
	timer.text = ""
	healthPoints = Global.player.maxHealth
	Global.player.damaged.connect(_on_ship_damaged)
	initHealth()
	
func _process(delta: float) -> void:
	if !Global.inSequence:
		time += delta
		timer.text = getTimeFormat(time)
		Global.time = timer.text
	
func initHealth() -> void:
	for i in range(Global.player.currentHealth):
		var hp = TextureRect.new()
		hp.texture = load("res://assets/health_filler.png")
		health.add_child(hp)
	
# time in milliseconds
func getTimeFormat(time: float) -> String:
	var mins = int(time / 60.0)
	var seconds = int(fmod(time, 60.0))
	var displaySeconds = "0" + str(seconds) if seconds < 10 else str(seconds)
	var displayMins = "0" + str(mins) if mins < 10 else str(mins)

	return displayMins + ":" + displaySeconds

func _on_ship_damaged() -> void:
	var hp := health.get_children()
	hp[-1].queue_free()
