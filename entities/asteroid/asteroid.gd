class_name Asteroid extends Node2D

@onready var detection: Area2D = $detection
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var explosionParticles: GPUParticles2D = $GPUParticles2D
@onready var collision: CollisionShape2D = $detection/CollisionShape2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var speed: int = 100
var rotateSpeed: float = 1.5

var direction: Vector2 = Vector2.ZERO
var size: String

func _ready() -> void:
	collision.shape = collision.shape.duplicate(true)
	detection.area_entered.connect(_on_detection_area_entered)
	explosionParticles.finished.connect(_on_particle_finish)
	match size:
		"big":
			sprite_2d.frame = 0
			collision.shape.radius = 16
		"medium":
			sprite_2d.frame = 1
			collision.shape.radius = 9
		"small":
			sprite_2d.frame = 2
			collision.shape.radius = 6
			
	
func _physics_process(delta: float) -> void:
	rotate(rotateSpeed * delta)
	global_position += direction * speed * delta

func _on_detection_area_entered(area: Area2D) -> void:
	if area.get_parent() is Bullet:
		explosionParticles.emitting = true
		sprite_2d.visible = false
		audio_stream_player_2d.play()
	if area.get_parent() is SpaceShip and sprite_2d.visible:
		area.get_parent().damage()
		explosionParticles.emitting = true
		sprite_2d.visible = false
		audio_stream_player_2d.play()
		
func _on_particle_finish() -> void:
	explosionParticles.emitting = false
	queue_free()
