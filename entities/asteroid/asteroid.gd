class_name Asteroid extends Node2D

@onready var detection: Area2D = $detection
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var explosionParticles: GPUParticles2D = $GPUParticles2D

var speed: int = 100
var rotateSpeed: float = 1.5

var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	detection.area_entered.connect(_on_detection_area_entered)
	explosionParticles.finished.connect(_on_particle_finish)
	
func _physics_process(delta: float) -> void:
	rotate(rotateSpeed * delta)
	global_position += direction * speed * delta
	
func setSize(size: String) -> void:
	animation_player.play(size + "_asteroid")

func _on_detection_area_entered(area: Area2D) -> void:
	if area.get_parent() is Bullet:
		explosionParticles.emitting = true
		sprite_2d.visible = false
	if area.get_parent() is SpaceShip and sprite_2d.visible:
		Global.gameOver.emit()
		
func _on_particle_finish() -> void:
	explosionParticles.emitting = false
	queue_free()
