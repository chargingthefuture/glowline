extends Node2D

# Simple hazard script for obstacles
export var speed = 200

func _process(delta):
	position.y += speed * delta
	if position.y > 1400:
		queue_free()
