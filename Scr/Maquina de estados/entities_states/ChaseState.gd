extends EntytiStateBase
class_name chase_state

@export var speed: float = 100.0 # Velocidad al perseguir
var player: Node2D = null


func start() -> void:
	pass

func on_process(delta: float) -> void:
	if player == null:
		return # No hay jugador que perseguir
	
	# Dirección hacia el jugador
	var direction = (player.position - Maid.position).normalized()
	Maid.velocity = direction * speed
	# Movimiento hacia el jugador
	Maid.position += direction * speed * delta
	Maid.move_and_animate(delta)

func end() -> void:
	Maid.velocity = Vector2.ZERO
	Maid.move_and_animate(0)


func _on_zona_deteccion_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null
		state_machine.change_to("PatrolState")
