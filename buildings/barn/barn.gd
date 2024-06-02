extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
#	$Interactable/InteractionRadius/CollisionShape2D.shape.radius = 150
	pass

func can_interact(player: Player):
	if player.item == null:
		return false
	if player.item.item_type == Item.ItemType.WHEAT:
		return true
	return false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Interactable_interacted_with(player: Player):
	GameManager.wheats += player.item.count
	player.item.queue_free()
	player.item = null
	
