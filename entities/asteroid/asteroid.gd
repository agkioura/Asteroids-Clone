class_name Asteroid extends Node2D

@onready var detection: Area2D = $detection
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var speed: int = 100
var rotateSpeed: float = 1.5

var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	detection.area_entered.connect(_on_detection_area_entered)
	
func _physics_process(delta: float) -> void:
	rotate(rotateSpeed * delta)
	global_position += direction * speed * delta
	
func setSize(size: String) -> void:
	animation_player.play(size + "_asteroid")

func _on_detection_area_entered(area: Area2D) -> void:
	if area.get_parent() is Bullet:
		print("hit")
		queue_free()
	#if area.get_parent() is SpaceShip:
		#get_tree().quit()
