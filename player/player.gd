extends KinematicBody2D

var speed = 200  # speed in pixels/sec
var velocity = Vector2.ZERO

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
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
