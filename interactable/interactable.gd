extends Node2D 
class_name Interactable

signal interacted_with(player)
export var hover_text = "E E E E"

func _ready():
	$Label.text = hover_text

func set_interaction_radius(radius):
	$InteractionRadius/CollisionShape2D.shape.radius = radius

func interact(player):
	emit_signal("interacted_with", player)

func start_hover():
	$Label.visible = true

func stop_hover():
	$Label.visible = false
