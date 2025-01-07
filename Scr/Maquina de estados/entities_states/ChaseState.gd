extends EntytiStateBase
class_name chase_state

@export var speed: float = 150.0 # Velocidad al perseguir

# Nodo del jugador (asignado al detectarlo)
var player: Node2D = null


func start() -> void:
	if player == null:
		print("ChaseState: No se asignó un jugador.")
	else:
		print("ChaseState: Iniciando persecución.")

func on_process(delta: float) -> void:
	if player == null:
		return # No hay jugador que perseguir
	
	# Dirección hacia el jugador
	var direction = (player.position - controlled_node.position).normalized()
	
	# Movimiento hacia el jugador
	controlled_node.position += direction * speed * delta
	
	# Actualizar la animación según la dirección
	_update_animation(direction)

func _update_animation(direction: Vector2) -> void:
	if direction.x > 0:
		Maid.anim.play("Walk_right")
	elif direction.x < 0:
		Maid.anim.play("Walk_left")
	elif direction.y > 0:
		Maid.anim.play("Walk_down")
	elif direction.y < 0:
		Maid.anim.play("Walk_up")

func end() -> void:
	Maid.anim.stop() # Detiene la animación al salir del estado


func _on_zona_deteccion_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Jugador detectado. Cambiando al estado de persecución.")
		player = null
		state_machine.change_to("PatrolState")
