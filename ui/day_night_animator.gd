extends AnimationPlayer

onready var game_manager: GameManager = get_node("/root/GameManager")
# Hack da ne bi playovao anim na prvom danu
var first_day = true

func _ready():
	game_manager.connect("night_started", self, "_on_night_started")
	game_manager.connect("day_started", self, "_on_night_ended")

func _on_night_started():
	play("to_night")

func _on_night_ended():
	play("to_day")
