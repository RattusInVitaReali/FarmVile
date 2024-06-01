extends KinematicBody2D

var target : Alien
const speed = 750
var velocity = Vector2.ZERO

func set_target(t: Alien):
	target = t

func _physics_process(delta):
	if target == null:
		return
	look_at(target.global_position)
	var direction = global_position.direction_to(target.global_position)
	velocity = direction * speed 
	velocity = move_and_slide(velocity)
	print(global_position.distance_to(target.global_position))
	if global_position.distance_to(target.global_position) <= 25:
		print("boom")
		target.take_damage()
		queue_free()

