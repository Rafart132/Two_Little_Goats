extends EntytiStateBase

class_name PatrolState

# Propiedades del estado
@export var patrol_points: Array[Vector2] = [] # Puntos a patrullar
@export var speed: float = 100.0 # Velocidad del enemigo


var current_point_index: int = 0 # Índice del punto de patrullaje actual

func start() -> void:
	if patrol_points.size() > 0:
		current_point_index = 0


func on_process(delta: float) -> void:
	if patrol_points.size() == 0:
		return # Si no hay puntos, no hace nada
	
	var target_point = patrol_points[current_point_index]
	var direction = (target_point - Maid.position).normalized()
	
	Maid.velocity = direction * speed
	Maid.move_and_animate(delta)
	
	# Comprueba si llegó al punto objetivo
	if Maid.position.distance_to(target_point) < 5.0:
		_go_to_next_point()
	

func _go_to_next_point() -> void:
	current_point_index += 1
	if current_point_index >= patrol_points.size():
		current_point_index = 0 # Reinicia el ciclo de patrullaje

func end() -> void:
	Maid.velocity = Vector2.ZERO
	Maid.move_and_animate(0)

func _on_zona_deteccion_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_parent().find_child("ChaseState").player = body
		state_machine.change_to("ChaseState")
