extends Node

var game: Game

signal gameOver

var arrow = load("res://assets/sprite_0.png")

func _ready():
	Input.set_custom_mouse_cursor(arrow)
