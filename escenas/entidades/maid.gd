extends CharacterBody2D
class_name maid

@onready var anim:AnimatedSprite2D = $AnimatedSprite2D
@onready var Detect:Area2D = $zona_deteccion

func _process(delta: float) -> void:
	move_and_animate(delta)

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
