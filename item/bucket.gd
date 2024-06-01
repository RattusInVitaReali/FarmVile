extends Item
class_name Bucket

export var max_water_level = 100
export(int) var water_level_decrement = 5

var empty_texture: Texture
var full_texture: Texture
var water_level: int

func use():
	if water_level > 0:
		water_level -= water_level_decrement
	update_sprite()

# Called when the node enters the scene tree for the first time.
func _ready():
	empty_texture = load("res://item/sprites/bucket_empty.png")
	full_texture = load("res://item/sprites/bucket_full.png")
	item_type = ItemType.BUCKET
	water_level = max_water_level
	update_sprite()

func update_sprite():
	if water_level <= 0:
		sprite.texture = empty_texture
	else:
		sprite.texture = full_texture
		
func fill():
	water_level = max_water_level
	update_sprite()
