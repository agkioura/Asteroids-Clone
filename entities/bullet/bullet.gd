class_name Bullet extends Node2D

var direction: Vector2 = Vector2.ZERO
var speed: int = 300

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
