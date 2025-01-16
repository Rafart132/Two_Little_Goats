extends Node

var player:Node2D = null

var player_hidden:bool = false

func  set_player(player_node:Node2D) -> void:
	player = player_node

func get_player() -> Node2D:
	return player

func set_player_hidden(is_hidden:bool) -> void:
	player_hidden = is_hidden
func get_player_hide():
	return player_hidden

func get_administrador_escenas():
	return get_node("/root/Administrador_Escena")
