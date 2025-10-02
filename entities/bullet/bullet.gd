class_name Bullet extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
var speed: int = 300

func _process(delta: float) -> void:
	velocity = direction * speed
	move_and_slide()
