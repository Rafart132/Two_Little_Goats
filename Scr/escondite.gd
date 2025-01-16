extends StaticBody2D

var player_inside = false

func _process(_delta: float) -> void:
	if not Ad.get_player_hide() and player_inside and Input.is_action_just_pressed("aceptar"):
		Ad.set_player_hidden(true)
		Ad.get_player().find_child("StateMachine").set_physics_process(false)
		Ad.get_player().anim.hide()
		print("escondido")
	elif player_inside and Ad.get_player_hide() and Input.is_action_just_pressed("aceptar"):
		Ad.set_player_hidden(false)
		Ad.get_player().find_child("StateMachine").set_physics_process(true)
		Ad.get_player().anim.show()
		print("te veo")

func _on_deteccion_escondite_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("aqui estas")
		player_inside = true

func _on_deteccion_escondite_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("aqui no estas")
		player_inside = false
