extends KinematicBody2D
class_name Player

var speed = 200  # speed in pixels/sec
var velocity = Vector2.ZERO

export(int) var player_id = 0

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right_%s' % player_id):
		velocity.x += 1
	if Input.is_action_pressed('ui_left_%s' % player_id):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down_%s' % player_id):
		velocity.y += 1
	if Input.is_action_pressed('ui_up_%s' % player_id):
		velocity.y -= 1
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

var current_interactable : Interactable = null

func _on_InteractableScaner_area_entered(area):
	if current_interactable != null:
		current_interactable.stop_hover()
	current_interactable = area.get_parent()
	current_interactable.start_hover()


func _on_InteractableScaner_area_exited(area):
	if current_interactable != null:
		current_interactable.stop_hover()
		current_interactable = null

func interact():
	if current_interactable != null:
		current_interactable 


var item : Item = null

func equip():
	pass


func drop():
	pass
