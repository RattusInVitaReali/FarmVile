extends Node2D 
class_name Interactable

signal interacted_with(player)
export var hover_text = "E E E E"

func _ready():
	$Label.text = hover_text


func interact(player):
	emit_signal("interacted_with", player)

func can_interact(player):
	if get_parent().has_method("can_interact"):
		return get_parent().can_interact(player)
	return true

func start_hover():
	$Label.visible = true

func stop_hover():
	$Label.visible = false

func enable():
	$InteractionRadius.monitorable = true
	
func disable():
	$InteractionRadius.monitorable = false
