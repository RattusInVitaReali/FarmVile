extends KinematicBody2D

const speed = 300
var max_hp = 3
var velocity = Vector2.ZERO

var hp = max_hp

var target : Crop

func set_target(new_target):
	target = new_target

func _physics_process(delta):
	if target == null:
		return
	var direction = position.direction_to(target.position)
	velocity = direction.normalized() * speed
	velocity = move_and_slide(velocity)


func take_damage():
	hp -= 1
	if hp <= 0:
		die()

func die():
	queue_free()
