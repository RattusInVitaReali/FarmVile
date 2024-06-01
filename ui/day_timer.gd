extends HBoxContainer

onready var game_manager : GameManager= get_node("/root/GameManager")
onready var label : Label = $Label
onready var icon : TextureRect = $Icon

onready var day_icon : Texture = preload("res://ui/sprites/sun_icon.png")
onready var night_icon : Texture = preload("res://ui/sprites/moon_icon.png")

func _ready():
	game_manager.connect("day_started", self, "_on_day_started")
	game_manager.connect("night_started", self, "_on_night_started")
	pass # Replace with function body.

func _process(delta):
	if game_manager.is_day:
		label.text = str(int(game_manager.day_timer.time_left))
	else:
		label.text = str(int(game_manager.night_timer.time_left))

func _on_day_started():
	icon.texture = day_icon

func _on_night_started():
	icon.texture = night_icon