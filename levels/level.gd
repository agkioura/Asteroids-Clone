extends Node2D

@onready var entities: Node2D = $Entities
var ship: SpaceShip

func _ready() -> void:
	ship = load("res://entities/space ship/space_ship.tscn").instantiate()
	ship.global_position = Vector2(100, 100)
	entities.add_child(ship)
