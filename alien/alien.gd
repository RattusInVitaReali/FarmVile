extends KinematicBody2D
class_name Alien

export var eating_time = 3
export var eating_steps = 3

onready var eating_indicator = $EatingIndicator

const speed = 50
var max_hp = 30
var velocity = Vector2.ZERO
var eating: bool = false
var eating_counter = 0

var hp = max_hp

var target : Crop

func _ready():
	var crops = get_tree().get_nodes_in_group("crops")
	set_target(crops[0])
	

func set_target(new_target):
	target = new_target

func _physics_process(delta):
	if target == null:
		return
	if eating:
		return
	var direction = global_position.direction_to(target.global_position)
	velocity = direction * speed 
	velocity = move_and_slide(velocity)
	if target.global_position.distance_to(global_position) < 10:
		eating = true
		$Timer.start(eating_time / eating_steps)

func take_damage():
	$CPUParticles2D.emitting = true
	hp -= 1
	print("OW: " + str(hp))
	if hp <= 0:
		die()

func die():
	queue_free()


func _on_Timer_timeout():
	eating_counter += 1
	eating_indicator.value = eating_counter * 100 / eating_steps
	if eating_counter == eating_steps:
		target.destroy()
		$Timer.stop()
		die()
