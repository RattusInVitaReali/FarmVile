extends KinematicBody2D
class_name Alien

const speed = 50
var max_hp = 30
var velocity = Vector2.ZERO
var eating: bool = false
var timer = null

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
		timer = Timer.new()
		timer.connect("timeout",self,"_on_timer_timeout") 
		timer.set_wait_time(3) #value is in seconds: 600 seconds = 10 minutes
		add_child(timer) 
		timer.start() 
		
func _on_timer_timeout():
	print("Destroying target")
	target.destroy()

func take_damage():
	$CPUParticles2D.emitting = true
	hp -= 1
	print("OW: " + str(hp))
	if hp <= 0:
		die()

func die():
	queue_free()
