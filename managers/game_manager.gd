extends Node2D

# Exported variables for day and night timers
var day_duration: float = 30 # Duration of the day in seconds
var night_duration: float = 30# Duration of the night in seconds

# Signals
signal night_started
signal day_started

# Member variables
var wheats = 0
var is_day = true
var day_timer: Timer
var night_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	day_timer = Timer.new()
	night_timer = Timer.new()
	
	print("Day duration: ", day_duration)

	day_timer.wait_time = day_duration
	night_timer.wait_time = night_duration

	add_child(day_timer)
	add_child(night_timer)

	day_timer.connect("timeout", self, "_on_day_timer_timeout")
	night_timer.connect("timeout", self, "_on_night_timer_timeout")
	
	day_timer.start()

# Function to start the day cycle
func start_day_cycle():
	print("Day started")
	is_day = true
	emit_signal("day_started")
	day_timer.start()

# Function to start the night cycle
func start_night_cycle():
	print("Night started")
	is_day = false
	emit_signal("night_started")
	night_timer.start()

# Function called when day timer times out
func _on_day_timer_timeout():
	day_timer.stop()
	start_night_cycle()

# Function called when night timer times out
func _on_night_timer_timeout():
	night_timer.stop()
	start_day_cycle()
