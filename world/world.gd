extends Node2D

const AlienScene = preload("res://alien/alien.tscn")

onready var timer = $Timer

var enemy_wave_size: int = 1
var enemy_count: int = 0
var is_night: bool = false

func _ready():
	GameManager.connect("night_started", self, "_on_night_started")
	GameManager.connect("day_started", self, "_on_new_day")

func _on_new_day():
	timer.stop()
	enemy_wave_size += 1.5

func _on_night_started():
	is_night = true
	enemy_count = 0
	# 0.5 i ((night_duartion / 2) / enemy_count)
	var end_duration = rand_range(0.5, ((GameManager.night_duration / 2.0) / enemy_wave_size))
	print("Spawning enemy in %s" % end_duration)
	timer.start(end_duration)

func spawn_alien():
	enemy_count += 1
	var new_alien = AlienScene.instance()
	var new_position: Vector2 = Vector2(rand_range(0, 500), rand_range(0, 500))
	new_alien.position = new_position
	
	$YSort.add_child(new_alien)
	
#	min_dist = 100000000000
#	for p in $YSort/Plots1:
#		if new_position.distance_to(p.position) < min_dist:
#			min_dist = new_position.distance_to(p.position)
#			new_alien.set_target(p)
	var crops = get_tree().get_nodes_in_group("crops")
	var new_target: Crop = crops[randi() % crops.size()]
	var iter = 0
	while new_target.locked:
		if iter == 1000:
			break;
		new_target = crops[randi() % crops.size()]
	new_alien.set_target(new_target)


func _on_Timer_timeout():
	if enemy_count == enemy_wave_size:
		timer.stop()
		return
	spawn_alien()
	timer.wait_time = rand_range(0.5, ((GameManager.night_duration / 2.0) / enemy_wave_size))
		

