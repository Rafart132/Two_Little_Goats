extends EntytiStateBase

class_name PatrolState

# Propiedades del estado
@export var patrol_points: Array[Vector2] = [] # Puntos a patrullar
@export var speed: float = 100.0 # Velocidad del enemigo


var current_point_index: int = 0

func start() -> void:
	if patrol_points.size() > 0:
		Maid.navi.set_target_position(patrol_points[current_point_index])

func on_process(delta: float) -> void:
	
	if patrol_points.size() == 0:
		return # Si no hay puntos, no hace nada
	
	var player = _find_player()
	if not Ad.get_player_hide():
		if player and Maid.can_see(player):
			get_parent().find_child("ChaseState").player = player
			state_machine.change_to("ChaseState")
			return
	
	
	if not Maid.navi.is_navigation_finished():
		_move_to_next_point(delta)
	else:
		_go_to_next_point()

func _move_to_next_point(delta: float) -> void:
		var direction = Maid.navi.get_next_path_position() - Maid.position
		if direction.length() > 0:
			direction = direction.normalized()
			Maid.velocity = direction * speed
			Maid.move_and_animate(delta)

func _go_to_next_point() -> void:
	current_point_index = (current_point_index + 1) % patrol_points.size()
	Maid.navi.set_target_position(patrol_points[current_point_index])

func _find_player() -> Node2D:
	for body in Maid.Detect.get_overlapping_bodies():
		if body.is_in_group("Player"):
			return body
	return null

func end() -> void:
	Maid.velocity = Vector2.ZERO
	Maid.move_and_animate(0)

func _on_zona_deteccion_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if not Ad.get_player_hide():
			get_parent().find_child("ChaseState").player = body
			state_machine.change_to("ChaseState")
