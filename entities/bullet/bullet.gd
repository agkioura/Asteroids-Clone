class_name Bullet extends Node2D

@onready var area_2d: Area2D = $Area2D

var direction: Vector2 = Vector2.ZERO
var speed: int = 300

func _ready() -> void:
	area_2d.area_entered.connect(_on_hit)

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_hit(_area: Area2D) -> void:
	queue_free()
