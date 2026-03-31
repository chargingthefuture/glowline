extends Node2D

# Player movement variables
var speed = 0.0
var max_speed = 600.0
var acceleration = 900.0
var turn_speed = 3.0
var velocity = Vector2.ZERO

func _ready():
	set_process(true)

func _process(delta):
	var input_dir = 0
	if Input.is_action_pressed("ui_left"):
		input_dir -= 1
	if Input.is_action_pressed("ui_right"):
		input_dir += 1

	# Touch controls for web/mobile
	for ev in get_viewport().get_mouse_position():
		# Placeholder for touch input logic
		pass

	rotation += input_dir * turn_speed * delta

	# Accelerate forward
	speed = min(speed + acceleration * delta, max_speed)
	velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta

	# Wall sliding and speed boost (placeholder)
	# TODO: Implement collision with track and boost

func _draw():
	# Draw neon rhombus for player
	var points = [Vector2(0, -28), Vector2(18, 0), Vector2(0, 28), Vector2(-18, 0)]
	draw_colored_polygon(points, Color(0.0, 1.0, 0.8, 0.9))
	# Neon glow effect (simple)
	for i in range(1, 4):
		draw_colored_polygon(points * (1 + i * 0.1), Color(0.0, 1.0, 0.8, 0.2 / i))

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if event.position.x < get_viewport_rect().size.x / 2:
			Input.action_press("ui_left")
		else:
			Input.action_press("ui_right")
	if event is InputEventScreenTouch and not event.pressed:
		Input.action_release("ui_left")
		Input.action_release("ui_right")
