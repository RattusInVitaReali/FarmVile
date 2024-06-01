extends Node2D

onready var anim: AnimatedSprite = $Sprite/Animation
onready var interactable: Interactable = $Interactable

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.visible = false
	interactable.set_interaction_radius(60)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func can_interact(player: Player):
	if player.item.item_type == Item.ItemType.BUCKET:
		print('Can interact')
		return true
	return false
	

func _on_Interactable_interacted_with(player: Player):
	print('Interacted with', player.item)
	if player.item.has_method('fill'):
		player.item.fill()
		anim.visible = true
		get_tree().create_timer(2.0).connect('timeout', self, 'hide_anim')

func hide_anim():
	anim.visible = false
	
