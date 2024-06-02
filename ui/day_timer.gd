extends VBoxContainer

onready var game_manager : GameManager= get_node("/root/GameManager")
onready var animator : AnimationPlayer = $AnimateIcon
onready var label : Label = $Label
onready var icon : TextureRect = $Icon
onready var wheat : Label = $Wheat

onready var day_icon : Texture = preload("res://ui/sprites/sun_icon.png")
onready var night_icon : Texture = preload("res://ui/sprites/moon_icon.png")

func _ready():
	game_manager.connect("day_started", self, "start_anim")
	game_manager.connect("night_started", self, "start_anim")
	pass # Replace with function body.

func _process(delta):
	wheat.text = str(int(game_manager.wheats))
	if game_manager.is_day:
		label.text = str(int(game_manager.day_timer.time_left))
	else:
		label.text = str(int(game_manager.night_timer.time_left))

func start_anim():
	animator.play("animate_in")

func change_icon():
	if game_manager.is_day:
		icon.texture = day_icon
	else:
		icon.texture = night_icon
