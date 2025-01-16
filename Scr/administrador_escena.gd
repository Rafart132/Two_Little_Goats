@icon("res://Assets/IconGodotNode/color/icon_map_2.png")
extends Node2D
class_name Administrador_Escena


#@onready var anim : AnimationPlayer = $TransicionPantalla/AnimationPlayer
@onready var EscenaActual = $EscenaActual
@onready var Menu = $Menu

var SiguienteEscena : String = ""
var player_location: Vector2 = Vector2(0, 0)

enum TransitionType { NOME, NEW_SCENE, ONLY_MENU }
var tipo_transicion = TransitionType.NEW_SCENE

func _ready() -> void:
	Menu.hide()
	# Configuración inicial
	#anim.play("Quitar")  # Asume que hay una animación llamada "Quitar"
	pass

func _input(_event: InputEvent) -> void:
	
	if Input.is_action_pressed("Menu"):
		print(tipo_transicion)
		transition_to_menu()
	if Input.is_action_pressed("back"):
		print(tipo_transicion)
		transition_to_nome()

func transition_to_scene(nueva_escena: String, spawn_location: Vector2) -> void:
	# Prepara la transición a una nueva escena
	print("Activando")
	SiguienteEscena = nueva_escena
	player_location = spawn_location
	tipo_transicion = TransitionType.NEW_SCENE
	end_transition()
	#anim.play("Colocar")  # Asume que hay una animación llamada "Colocar"

func transition_to_nome() -> void:
	tipo_transicion = TransitionType.NOME
	end_transition()

func transition_to_menu() -> void:
	# Muestra el menú
	tipo_transicion = TransitionType.ONLY_MENU
	end_transition()
	#anim.play("Colocar")

func end_transition() -> void:
	# Finaliza la transición dependiendo del tipo
	match tipo_transicion:
		TransitionType.NOME:
			Menu.hide()
			var player = Ad.get_player()
			player.find_child("StateMachine").set_physics_process(true)
		
		TransitionType.NEW_SCENE:
			# Carga la nueva escena
			EscenaActual.get_child(0).queue_free()  # Elimina la escena actual
			var nueva_escena = load(SiguienteEscena).instantiate()  # Instancia la nueva escena
			EscenaActual.add_child(nueva_escena)  # Añade la nueva escena a EscenaActual
			
			# Configura la posición del jugador
			var player = Ad.get_player()
			player.set_spawn(player_location)
		
		TransitionType.ONLY_MENU:
			var player = Ad.get_player()
			player.find_child("StateMachine").set_physics_process(false)
			Menu.show()  # Muestra el menú o el nodo correspondiente
	
	# Reproduce la animación de cierre
	#anim.play("Quitar")
	
