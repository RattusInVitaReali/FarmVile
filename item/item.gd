extends Node2D
class_name Item

enum ItemType {SICKLE, GUN, BUCKET}

export(ItemType) var item_type
export(Texture) var item_texture

func use():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	if item_texture != null:
		$Sprite.texture = item_texture
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Interactable_interacted_with(player):
	player.equip(self)
