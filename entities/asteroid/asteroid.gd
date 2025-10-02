class_name Asteroid extends Node2D

@onready var detection: Area2D = $detection

func _ready() -> void:
	detection.area_entered.connect(_on_detection_area_entered)

func _on_detection_area_entered(area: Area2D) -> void:
	print("hit")
	queue_free()
