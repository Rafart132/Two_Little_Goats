extends CharacterBody2D
class_name maid


@export var rango_vision:int = 222

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
		move_and_slide()
		_update_animation()
	else:
		anim.stop()

func _update_animation() -> void:
	if velocity.x > 0:
		anim.play("Walk_right")
	elif velocity.x < 0:
		anim.play("Walk_left")

	elif velocity.y > 0:
		anim.play("Walk_down")
	elif velocity.y < 0:
		anim.play("Walk_up")
#endregion
