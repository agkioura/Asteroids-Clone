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
		Global.time = time
		timer.text = Global.getTimeFormat(time)
	
func initHealth() -> void:
	for i in range(Global.player.currentHealth):
		var hp = TextureRect.new()
		hp.texture = load("res://assets/sprites/health_filler.png")
		health.add_child(hp)

func _on_ship_damaged() -> void:
	var hp := health.get_children()
	if hp:
		hp[-1].queue_free()
