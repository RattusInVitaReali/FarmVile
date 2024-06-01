extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func can_interact(player: Player):
	if player.item.item_type == Item.ItemType.BUCKET:
		true
	

func _on_Interactable_interacted_with(player: Player):
	if player.item.has_method('fill'):
		player.item.fill()
	
