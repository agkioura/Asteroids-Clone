extends Node2D

@onready var entities: Node2D = $Entities
@onready var area_2d: Area2D = $Area2D
@onready var spawn_points: Node2D = $SpawnPoints
@onready var spawn_timer: Timer = $SpawnTimer

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var positions: Array = []

var ship: SpaceShip

func _ready() -> void:
	Global.gameOver.connect(_on_game_over)
	
	area_2d.area_entered.connect(_on_area_connect)
	
	ship = load("res://entities/space ship/space_ship.tscn").instantiate()
	ship.global_position = Vector2(240, 135)
	entities.add_child(ship)
	
	for spawnPoint in spawn_points.get_children():
		positions.append(spawnPoint.global_position)
		
func _process(_delta: float) -> void:
	if spawn_timer.is_stopped():
		spawnAstroid()

func spawnAstroid() -> void:
	for i in range(rng.randi_range(3,4)):
		var index = rng.randi_range(0, positions.size() - 1)
		var asteroid = load("res://entities/asteroid/asteroid.tscn").instantiate()
		asteroid.global_position = positions[index]
		var randomOffset = Vector2(rng.randi_range(0, 200), rng.randi_range(0, 200))
		asteroid.direction = asteroid.global_position.direction_to(ship.global_position + randomOffset)
		entities.add_child(asteroid)
		
		var type = rng.randi_range(0, 2)
		match type:
			0:
				asteroid.setSize("big")
			1:
				asteroid.setSize("medium")
			2:
				asteroid.setSize("small")
		
	spawn_timer.start(2)

func _on_area_connect(area: Area2D) -> void:
	print("despawn")
	area.get_parent().queue_free()
	
func _on_game_over() -> void:
	queue_free()
