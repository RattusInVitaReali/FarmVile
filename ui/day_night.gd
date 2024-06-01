extends ColorRect

func _ready():
	self.material.set_shader_param("time_of_day", 1.0)
