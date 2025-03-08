extends EntytiStateBase
class_name chase_state

var player: CharacterBody2D = null
@onready var tim:Timer = $"../../Timer"

func start() -> void:
	if Maid.ray:
		Maid.ray.force_raycast_update()
	if player == null:
		player = Ad.get_player()
	if Maid.navi:
		Maid.navi.set_target_position(player.global_position)

func on_process(delta: float) -> void:
	if player == null:
		state_machine.change_to("PatrolState")
		return # No hay jugador que perseguir
	
	if Maid.can_see(player):
		if tim.is_stopped() == false:
			tim.stop()
		Maid.navi.set_target_position(player.global_position)
	elif tim.is_stopped():
		tim.start()
	
	if Ad.get_player_hide():
		state_machine.change_to("PatrolState")
		return
	# Dirección hacia el jugador
	var next_position = Maid.navi.get_next_path_position()
	var direction = (next_position - Maid.global_position).normalized()
	Maid.velocity = direction * Maid.speed
	Maid.move_and_animate(delta)
	Maid.ray.force_raycast_update()

func end() -> void:
	Maid.velocity = Vector2.ZERO
	Maid.move_and_animate(0)

func _on_zona_deteccion_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if not Ad.get_player_hide():
			if tim.is_stopped():
				tim.start()

func _on_timer_timeout() -> void:
	state_machine.change_to("PatrolState")
