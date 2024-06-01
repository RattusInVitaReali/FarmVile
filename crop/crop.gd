extends Node2D

# Enum for crop states
enum CropState { EMPTY, SEEDED, STAGE_1, STAGE_2, RIPE, WITHERED, CORRUPTED }

# Exported variables
export(float) var water_level: float = 100.0
export(float) var water_depletion_rate: float = 1.0

export(Array, Texture) var crop_stages: Array
export(Texture) var empty_crop_sprite: Texture
export(Texture) var withered_crop_sprite: Texture
export(Texture) var corrupted_crop_sprite: Texture

onready var sprite : Sprite= $Sprite
onready var water_indicator: ProgressBar = $WaterIndicator

# Member variables
var crop_state: int = CropState.EMPTY
var day_manager = null

# Function to handle day and night cycle subscription
func _ready():
#	day_manager = get_node("/root/DayManager") # Adjust the path to your DayManager singleton
#	if day_manager:
#		day_manager.connect("night_cycle", self, "_on_night_cycle")
	update_crop_sprite()

func _process(delta):
	deplete_water(delta)
	water_indicator.value = water_level

# Function called on each night cycle
func _on_night_cycle():
	advance_growth_stage()

# Function to advance the crop growth stage
func advance_growth_stage():
	match crop_state: 
		CropState.CORRUPTED, CropState.WITHERED:
			pass
		
	if crop_state < CropState.RIPE:
		crop_state += 1
	update_crop_sprite()

# Function to deplete water level
func deplete_water(delta):
	water_level -= water_depletion_rate * delta
	if water_level <= 0:
		crop_state = CropState.WITHERED
	update_crop_sprite()

# Function to update crop sprite based on the state
func update_crop_sprite():
	if crop_state == CropState.EMPTY:
		sprite.texture = empty_crop_sprite
	elif crop_state == CropState.WITHERED:
		sprite.texture = withered_crop_sprite
	elif crop_state == CropState.CORRUPTED:
		sprite.texture = corrupted_crop_sprite
	else:
		var crop_sprites = crop_stages
		if crop_sprites.size() > int(crop_state):
			sprite.texture = crop_sprites[int(crop_state)]
		else:
			printerr("Crop state out of range: ", crop_state)

# Function to reset crop state and water level
func reset_crop():
	crop_state = CropState.EMPTY
	water_level = 100.0
	update_crop_sprite()
