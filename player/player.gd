extends KinematicBody2D
class_name Player

var speed = 200  # speed in pixels/sec
var velocity = Vector2.ZERO
var item:Item
var current_interactable : Interactable = null

export(int) var player_id = 0

func _ready():
	$PlayerAnimation/AnimationPlayer.play("Idle")

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
	if Input.is_action_just_pressed("ui_interact_%s" % player_id):
		interact()
	if Input.is_action_just_pressed("ui_drop_%s" % player_id):
		drop()
	if Input.is_action_just_pressed("ui_shoot"):
		shoot()
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed
	if $PlayerAnimation/AnimationPlayer.current_animation == "Idle" and velocity != Vector2.ZERO:
		$PlayerAnimation/AnimationPlayer.play("Walk")
	if $PlayerAnimation/AnimationPlayer.current_animation == "Walk" and velocity == Vector2.ZERO:
		$PlayerAnimation/AnimationPlayer.play("Idle")
	if velocity.x > 0:
		$PlayerAnimation.scale = Vector2(-0.1, 0.1)
	elif velocity.x < 0:
		$PlayerAnimation.scale = Vector2(0.1, 0.1)

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)


func _on_InteractableScaner_area_entered(area):
	var interactable = area.get_parent()
	if interactable.can_interact(self):
		if current_interactable != null:
			current_interactable.stop_hover()
		current_interactable = interactable
		current_interactable.start_hover()

func _on_InteractableScaner_area_exited(area):
	if current_interactable != area.get_parent():
		return
	if current_interactable != null:
		current_interactable.stop_hover()
		current_interactable = null
	var areas = $InteractableScaner.get_overlapping_areas()
	var closest = null
	for a in areas:
		if closest == null or a.position.distance_to(position) < closest.position.distance_to(position):
			if a.get_parent().can_interact(self):
				closest = a
	if closest != null:
		current_interactable = closest.get_parent()
		current_interactable.start_hover()

func interact():
	if current_interactable == null:
		return
	current_interactable.interact(self)
	if current_interactable != null and !current_interactable.can_interact(self):
		current_interactable.stop_hover()
		current_interactable = null

func drop():
	if (item != null and is_instance_valid(item)):
		item.get_parent().remove_child(item)
		get_parent().add_child(item)
		item.position = position
		## da ne bi bilo u centru, vec ispred player-a
		item.position.x += 30
		item.position.y += 20
		item.enable()
		item = null

func shoot():
	if item == null:
		return
	if item.item_type == Item.ItemType.GUN:
		item.shoot(self)

func equip(new_item: Item):
	drop()
	item = new_item
	item.get_parent().remove_child(item)
	add_child(item)
	item.position = Vector2(0,-120)
	item.disable()
