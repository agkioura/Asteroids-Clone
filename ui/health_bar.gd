extends CanvasLayer

@onready var health: HBoxContainer = $MarginContainer/TextureRect/HBoxContainer
var healthPoints: int

func _ready() -> void:
	healthPoints = Global.player.maxHealth
	Global.player.damaged.connect(_on_ship_damaged)
	initHealth()

func initHealth() -> void:
	for i in range(healthPoints):
		var hp = TextureRect.new()
		hp.texture = load("res://assets/health_filler.png")
		health.add_child(hp)

func _on_ship_damaged() -> void:
	var hp := health.get_children()
	hp[-1].queue_free()
