extends PlayerStateBase

func start():
	pass

func on_physics_process(_delta):	
	player.velocity.x = 0
	player.velocity.y = 0
	$"../../Anim".play(player.last_direccion)
	controlled_node.move_and_slide()
 
func on_input(_event: InputEvent) -> void:
	
	
	
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine.change_to(PlayerStateNames.Walk)
	elif Input.is_action_pressed("ui_accept"):
		state_machine.change_to(PlayerStateNames.Run)
