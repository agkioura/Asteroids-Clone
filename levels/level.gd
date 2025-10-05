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
	
	ship = preload("res://entities/space ship/space_ship.tscn").instantiate()
	ship.global_position = Vector2(240, 135)
	
	Global.player = ship
	
	entities.add_child(ship)
	
	for spawnPoint in spawn_points.get_children():
		positions.append(spawnPoint.global_position)
		
	Global.game.loadGui("res://ui/player_ui.tscn")
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and !Global.paused and !Global.inSequence:
		Global.game.loadGui("res://menus/pause menu/pause_menu.tscn")

func _process(delta: float) -> void:
	if spawn_timer.is_stopped() and !Global.inSequence:
		spawnAstroids()
		spawn_timer.start(2)

func spawnAstroids() -> void:
	for i in range(rng.randi_range(3,4)):
		var index = rng.randi_range(0, positions.size() - 1)
		var asteroid = preload("res://entities/asteroid/asteroid.tscn").instantiate()
		asteroid.global_position = positions[index]
		var randomOffset = Vector2(rng.randi_range(0, 200), rng.randi_range(0, 200))
		asteroid.direction = asteroid.global_position.direction_to(ship.global_position + randomOffset)
		
		var type = rng.randi_range(0, 2)
		match type:
			0:
				asteroid.size = "big"
			1:
				asteroid.size = "medium"
			2:
				asteroid.size = "small"
		
		entities.add_child.call_deferred(asteroid)

func _on_area_connect(area: Area2D) -> void:
	area.get_parent().queue_free()
	
func _on_game_over() -> void:
	Global.inSequence = true
	gameOverSequence()

func gameOverSequence():
	ship.explode()
	Global.game.loadGui("res://menus/gameover menu/game_over_screen.tscn")
