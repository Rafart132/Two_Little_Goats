extends CharacterBody2D
class_name maid


@export var rango_vision:int = 222
@export var patrol_points: Array[Vector2] = []
@export var speed: float = 100.0

@onready var anim:AnimatedSprite2D = $AnimatedSprite2D
@onready var Detect:Area2D = $zona_deteccion
@onready var ray:RayCast2D =$RayCast2D
@onready var navi:NavigationAgent2D =$NavigationAgent2D

var can_see_player:bool = false

func can_see(target: Node2D) -> bool:
	
	ray.target_position = (target.global_position - global_position).normalized() * rango_vision
	ray.force_raycast_update()
	return ray.is_colliding() and ray.get_collider() == target
	

#region ACTUALIZAR ANIMACION
func move_and_animate(_delta: float) -> void:
	if velocity.length() > 0:
		if velocity.y != 0:
			velocity.y /= 4
		_update_animation()
		move_and_slide()
	else:
		anim.stop()

func _update_animation() -> void:
	if velocity.length() > 0.1:
		if abs(velocity.y) > abs(velocity.x):
			if velocity.y > 0:
				anim.play("Walk_down")
			else:
				anim.play("Walk_up")
		else:
			if velocity.x > 0:
				anim.play("Walk_right")
			else:
				anim.play("Walk_left")

#endregion
