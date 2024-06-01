extends Node2D

# Enum for crop states
enum CropState { EMPTY, SEEDED, STAGE_1, STAGE_2, RIPE, WITHERED, CORRUPTED }

# Exported variables
export(float) var water_level: float = 100.0
export(float) var water_depletion_rate: float = 1.0

export(Texture) var seeded_crop_sprite: Texture
export(Texture) var stage_1_crop_sprite: Texture
export(Texture) var stage_2_crop_sprite: Texture
export(Texture) var ripe_crop_sprite: Texture
export(Texture) var empty_crop_sprite: Texture
export(Texture) var withered_crop_sprite: Texture
export(Texture) var corrupted_crop_sprite: Texture

onready var sprite : Sprite= $Sprite
onready var water_indicator: ProgressBar = $WaterIndicator
onready var interactable: Interactable = $Interactable

# Member variables
var crop_state: int = CropState.EMPTY
var day_manager = null

# Function to handle day and night cycle subscription
func _ready():
#	day_manager = get_node("/root/DayManager") # Adjust the path to your DayManager singleton
#	if day_manager:
#		day_manager.connect("night_cycle", self, "_on_night_cycle")
	update_crop_sprite()
	interactable.set_interaction_radius(80)

	get_tree().create_timer(0.5).connect("timeout", self, "_on_new_day")
	get_tree().create_timer(1.2).connect("timeout", self, "_on_new_day")
	get_tree().create_timer(2).connect("timeout", self, "_on_new_day")
	get_tree().create_timer(3).connect("timeout", self, "_on_new_day")

func _process(delta):
	deplete_water(delta)
	water_indicator.value = water_level

# Function called on each night cycle
func _on_new_day():
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
	elif crop_state == CropState.SEEDED:
		sprite.texture = seeded_crop_sprite
	elif crop_state == CropState.STAGE_1:
		sprite.texture = stage_1_crop_sprite
	elif crop_state == CropState.STAGE_2:
		sprite.texture = stage_2_crop_sprite
	elif crop_state == CropState.RIPE:
		sprite.texture = ripe_crop_sprite


# Function to reset crop state and water level
func reset_crop():
	crop_state = CropState.EMPTY
	water_level = 100.0
	update_crop_sprite()

func can_interact(player: Player) -> bool:
	if player.item != null:
		if player.item.item_type == Item.ItemType.BUCKET:
			return true
		if player.item.item_type == Item.ItemType.SICKLE:
			if crop_state == CropState.RIPE:
				return true
			return false
	return false


func _on_Interactable_interacted_with(player: Player):
	if player.item.item_type == Item.ItemType.BUCKET:
		water_level = 100
		update_crop_sprite()
		return