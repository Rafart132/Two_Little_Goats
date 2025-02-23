class_name Player
extends CharacterBody2D

@export var speed:float = 100
@export var VerticalSpeed:float = .3

@onready var anim:AnimatedSprite2D = $Anim

var last_direccion = "Idle_Down"
var direction = Vector2.ZERO
var input_direccion:Vector2 = Vector2(0,1)

var states:PlayerStateNames = PlayerStateNames.new()

@onready var movimientos = [Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")]
@onready var movimientosNOT = [ not Input.is_action_pressed("ui_down") or not Input.is_action_pressed("ui_up") or not Input.is_action_pressed("ui_left") or not Input.is_action_pressed("ui_right")]

func set_spawn(locacion: Vector2):
	
	position = locacion
