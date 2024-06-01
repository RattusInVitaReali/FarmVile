extends Item
class_name BUCKET

export var water_level = 100
export(int) var water_level_decrement = 5


func use():
	water_level -= water_level_decrement

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
