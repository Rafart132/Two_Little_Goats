@icon("res://Assets/IconGodotNode/node_2D/icon_door.png")
extends Node

@export_file() var nueva_escena = ""
@export var spawn_location: Vector2 = Vector2(0,0)

@onready var Sprite: Sprite2D = $Sprite2D

var player_entered:bool = false

func _physics_process(_delta: float) -> void:
	if player_entered and Input.is_action_pressed("aceptar"):
		print("PiPuPa")
		puerta_cerrada()

func puerta_cerrada():
	Ad.get_administrador_escenas().transition_to_scene(nueva_escena, spawn_location)


func _on_deteccion_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print(body)
		player_entered = true

func _on_deteccion_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_entered = false
