extends Node2D

@onready var player = $player

func _ready() -> void:
	Ad.set_player(player)
