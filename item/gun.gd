extends Item

const Bullet = preload("res://item/bullet.tscn")

func shoot(player: Player):
	var bodies = $Area2D.get_overlapping_bodies()
	if bodies.size() == 0:
		return
	var closest = bodies[0]
	for body in bodies:
		if body.global_position.distance_to(global_position) < closest.global_position.distance_to(global_position):
			closest = body
	look_at(closest.global_position)
	var bullet = Bullet.instance()
	player.get_parent().add_child(bullet)
	bullet.set_target(closest)
	bullet.position = player.position
