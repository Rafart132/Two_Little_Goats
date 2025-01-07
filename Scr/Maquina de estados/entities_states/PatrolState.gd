extends EntytiStateBase

class_name PatrolState

# Propiedades del estado
@export var patrol_points: Array[Vector2] = [] # Puntos a patrullar
@export var speed: float = 100.0 # Velocidad del enemigo
@export var speedY: float = 50.0 # Velocidad del enemigo


var current_point_index: int = 0 # Índice del punto de patrullaje actual

func start() -> void:
	# Comienza moviéndose hacia el primer punto
	if patrol_points.size() > 0:
		current_point_index = 0

func on_process(delta: float) -> void:
	if patrol_points.size() == 0:
		return # Si no hay puntos, no hace nada
	
	var target_point = patrol_points[current_point_index]
	var direction = (target_point - controlled_node.position).normalized()
	
	# Movimiento hacia el punto
	controlled_node.position += direction * speed * delta
	
	
	# Comprueba si llegó al punto objetivo
	if controlled_node.position.distance_to(target_point) < 5.0:
		_go_to_next_point()
	
	anim(direction)

func anim(direction):
	if direction.x < 0:
		Maid.anim.play("Walk_left")
	if direction.x > 0:
		Maid.anim.play("Walk_right")
	if direction.y < 0:
		Maid.anim.play("Walk_up")
	if direction.y > 0:
		Maid.anim.play("Walk_down")

func _go_to_next_point() -> void:
	# Cambia al siguiente punto en la lista
	current_point_index += 1
	if current_point_index >= patrol_points.size():
		current_point_index = 0 # Reinicia el ciclo de patrullaje

func end() -> void:
	# Limpia cualquier variable si es necesario
	pass


func _on_zona_deteccion_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Jugador fuera de rango. Volviendo al estado de patrullaje.")
		get_parent().find_child("ChaseState").player = body
		state_machine.change_to("ChaseState")
