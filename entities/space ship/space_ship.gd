class_name SpaceShip extends CharacterBody2D

signal damaged

@export var speed: int = 100
@export var turnSpeed: float = 3.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var marker_2d: Marker2D = $Marker2D
@onready var shoot_cooldown: Timer = $ShootCooldown
@onready var i_frames: Timer = $iFrames
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var direction: Vector2 = Vector2.ZERO
var lookDirection: Vector2 = Vector2(0, -1)

var maxHealth: int = 4
var currentHealth: int = 4

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if !Global.inSequence:
		moveShip(delta)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and shoot_cooldown.is_stopped() and !Global.inSequence:
		shoot()
		shoot_cooldown.start(0.5)
	
func moveShip(delta: float) -> void:
	setDirection()
	if direction.x > 0:
		rotate(turnSpeed * delta)
	elif direction.x < 0:
		rotate(-turnSpeed * delta)

	# -pi/2 to correct the ship is sprite direction
	lookDirection = Vector2(cos(global_rotation - PI / 2), sin(global_rotation - PI / 2))
	
	if direction.y < 0:
		velocity = velocity.lerp(lookDirection * speed, delta)
	elif direction.y >= 0:
		velocity = velocity.lerp(Vector2.ZERO, delta)
	move_and_slide()
	
func setDirection() -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
func shoot() -> void:
	var bullet = load("res://entities/bullet/bullet.tscn").instantiate()
	bullet.global_position = marker_2d.global_position
	bullet.direction = lookDirection
	get_parent().add_child.call_deferred(bullet)
	

func damage() -> void:
	if i_frames.is_stopped() and !Global.inSequence:
		audio_stream_player_2d.play()
		damaged.emit()
		if currentHealth - 1 > 0:
			currentHealth -= 1
			i_frames.start(0.5)
			animation_player.play("damaged")
		else:
			Global.gameOver.emit()
			
func explode():
	sprite.visible = false
	gpu_particles_2d.emitting = true
