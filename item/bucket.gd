extends Item
class_name BUCKET

export var water_level = 100
export(int) var water_level_decrement = 5

var empty_texture: Texture
var full_texture: Texture

func use():
	if water_level > 0:
		water_level -= water_level_decrement
	update_sprite()
	print("Water level: ", water_level)

# Called when the node enters the scene tree for the first time.
func _ready():
	empty_texture = load("res://item/sprites/bucket_empty.png")
	full_texture = load("res://item/sprites/bucket_full.png")
	update_sprite()
	
func update_sprite():
	if water_level <= 0:
		item_texture = empty_texture
	else:
		item_texture = full_texture
