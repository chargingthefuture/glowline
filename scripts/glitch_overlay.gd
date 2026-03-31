extends Node2D

# Simple neon glitch effect for overlay
var glitch_timer = 0.0
var glitch_intensity = 0.0

func _process(delta):
	if glitch_intensity > 0:
		glitch_timer += delta
		if glitch_timer > 0.05:
			glitch_timer = 0
			update()

func trigger_glitch(intensity = 1.0):
	glitch_intensity = intensity
	glitch_timer = 0
	update()

func _draw():
	if glitch_intensity > 0:
		for i in range(int(glitch_intensity * 10)):
			var x = randf_range(0, 720)
			var y = randf_range(0, 1280)
			var w = randf_range(20, 120)
			var h = randf_range(2, 8)
			var color = Color(0.0, 1.0, 0.8, randf_range(0.1, 0.4))
			draw_rect(Rect2(x, y, w, h), color)
		glitch_intensity = max(0, glitch_intensity - 0.1)
