extends Node2D
class_name Item

enum ItemType {SICKLE, GUN, BUCKET, WHEAT, SEED}

export(ItemType) var item_type
export(Texture) var item_texture
export var locked = false
export var cost = 5

onready var sprite: Sprite = $Sprite

func use():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	if locked:
		$Padlock.visible = true
		$Label.visible = true
	if item_texture != null:
		$Sprite.texture = item_texture
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	$Label.text = str(cost)

func _on_Interactable_interacted_with(player):
	if locked:
		if GameManager.wheats >= cost:
			GameManager.wheats -= cost
			locked = false
			player.equip(self)
			$Padlock.visible = false
			$Label.visible = false
		else:
			return
	else:
		player.equip(self)

func enable():
	$LargeShadow.visible = true
	$Interactable.enable()
	
func disable():
	$LargeShadow.visible = false
	$Interactable.disable()
