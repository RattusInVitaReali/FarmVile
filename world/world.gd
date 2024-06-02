extends Node2D

const AlienScene = preload("res://alien/alien.tscn")

onready var timer = $Timer

func _ready():
	GameManager.connect("night_started", self, "_on_night_started")

func _on_night_started():
	$NightTimer.start(15)

func spawn_alien():
	var new_alien = AlienScene.instance()
	$YSort.add_child(new_alien)
	new_alien.set_target()


func _on_Timer_timeout():
	spawn_alien()
	if !$NightTimer.is_stopped():
		timer.start(rand_range(1.0, 2.0))
