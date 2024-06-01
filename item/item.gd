extends Node2D
class_name Item

export(String) var Name
export(Texture) var ItemTexture

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var itemName

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = ItemTexture
	itemName = Name
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Interactable_interacted_with(player):
	# TODO player.equip(self)
	pass # Replace with function body.
