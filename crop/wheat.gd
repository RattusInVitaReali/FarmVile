extends Item
class_name Wheat

var count = 1


func _on_Interactable_interacted_with(player : Player):
	print("Wheat")
	if player.item.item_type == Item.ItemType.WHEAT:
		print("Stacked")
		player.item.count += count
		player.current_interactable = null
		queue_free()
	else:
		player.equip(self)


func _process(delta):
	$Label.text = str(count)
