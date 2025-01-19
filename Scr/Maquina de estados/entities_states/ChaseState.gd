extends EntytiStateBase
class_name chase_state

@export var speed: float = 100.0 # Velocidad al perseguir
var player: CharacterBody2D = null


func start() -> void:
	if Maid.ray:
		Maid.ray.force_raycast_update()
	if player == null:
		player = Ad.get_player()

func on_process(delta: float) -> void:
	if player == null or not Maid.can_see(player):
		state_machine.change_to("PatrolState")
		return # No hay jugador que perseguir
		
	elif Ad.get_player_hide():
		state_machine.change_to("PatrolState")
		return
	# Dirección hacia el jugador
	var direction = (player.position - Maid.position).normalized()
	Maid.velocity = direction * speed
	Maid.move_and_animate(delta)
	Maid.ray.force_raycast_update()

func end() -> void:
	Maid.velocity = Vector2.ZERO
	Maid.move_and_animate(0)

func _on_zona_deteccion_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if not Ad.get_player_hide():
			player = null
