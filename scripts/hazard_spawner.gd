extends Node2D

# Spawns hazards during hazard levels
export var spawn_interval = 1.0
var timer = 0.0

func _process(delta):
	if not is_inside_tree():
		return
	timer += delta
	if timer > spawn_interval:
		timer = 0
		spawn_hazard()

func spawn_hazard():
	var hazard_scene = preload("res://scenes/Hazard.tscn")
	var hazard = hazard_scene.instance()
	hazard.position = Vector2(rand_range(120, 600), -40)
	get_parent().add_child(hazard)
