extends PlayerStateBase


	

func on_physics_process(_delta: float) -> void:
	update_animation()
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).normalized()
		
		
	
	if input_vector.y != 0:
		input_vector.y *= player.VerticalSpeed
		 
	player.velocity = input_vector * player.speed
	player.move_and_slide()
	
func update_animation() -> void:
	# Cambia la animación según la dirección de movimiento y guardando la ultima direccion
	if player.velocity.length() > 0.1:
		if abs(player.velocity.y) > abs(player.velocity.x):
			if player.velocity.y > 0:
				$"../../Anim".play("Walk_Down")
				player.last_direccion = "Idle_Down"
			else:
				$"../../Anim".play("Walk_Up")
				player.last_direccion = "Idle_Up"
		else:
			if player.velocity.x > 0:
				$"../../Anim".play("Walk_Right")
				player.last_direccion = "Idle_Right"
			else:
				$"../../Anim".play("Walk_Left")
				player.last_direccion = "Idle_Left"

func on_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_accept"):
		player.speed = 200
	else:
		player.speed = 100
	
	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		state_machine.change_to(PlayerStateNames.Idle)
