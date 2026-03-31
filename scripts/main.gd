extends Node2D

onready var dialogue_manager = $DialogueLayer/DialogueManager


var act = 1
var scene = 1
var branch = "none" # "broker" or "pulse"

# Hazard spawning
onready var player = $Player
var hazard_scene = preload("res://scenes/Hazard.tscn")
var hazard_timer = null

func _ready():
	hazard_timer = Timer.new()
	hazard_timer.wait_time = 1.2
	hazard_timer.connect("timeout", self, "_spawn_hazard")
	add_child(hazard_timer)
	start_act1_scene1()

func start_act1_scene1():
	var dialogue = [
		"Broker: GL-1N3, online. Ready for another day of deliveries?",
		"GL-1N3: Always, Broker. Where to?",
		"Broker: Sector 7 is waiting. Stay efficient."
	]
	dialogue_manager.show_dialogue(dialogue, funcref(self, "start_act1_scene2"))

func start_act1_scene2():
	# TODO: Start simple race/level here
	var dialogue = ["Broker: Efficient work. As expected."]
	dialogue_manager.show_dialogue(dialogue, funcref(self, "start_act1_scene3"))

func start_act1_scene3():
	var dialogue = [
		"GL-1N3: Did you see that flicker?",
		"Broker: Irrelevant. Continue your task."
	]
	dialogue_manager.show_dialogue(dialogue, funcref(self, "start_act2_scene1"))

func start_act2_scene1():
	var dialogue = [
		"The Pulse: ...can you hear me? You’re not safe. Broker is hiding the truth.",
		"GL-1N3: Who are you? What’s happening?",
		"Broker: Ignore the interference. Focus on your mission."
	]
	dialogue_manager.show_dialogue(dialogue, funcref(self, "start_act2_scene2"))

func start_act2_scene2():
	# Start hazards for this level
	hazard_timer.start()
	var dialogue = ["Broker: This sector is unstable. Proceed with caution."]
	dialogue_manager.show_dialogue(dialogue, funcref(self, "_wait_for_hazard_level"))

func _wait_for_hazard_level():
	# Wait for player to survive hazards for a few seconds
	yield(get_tree().create_timer(4.0), "timeout")
	hazard_timer.stop()
	for h in get_tree().get_nodes_in_group("hazards"):
		h.queue_free()
	var dialogue = ["GL-1N3: That was close. The corruption is spreading.", "Broker: I will handle it. You just deliver."]
	dialogue_manager.show_dialogue(dialogue, funcref(self, "start_act2_scene3"))
func _spawn_hazard():
	var hazard = hazard_scene.instance()
	hazard.position = Vector2(randi() % 600 + 60, -40)
	hazard.add_to_group("hazards")
	add_child(hazard)

func start_act2_scene3():
	var dialogue = [
		"The Pulse: Broker is isolating the Core. You must help me.",
		"GL-1N3: Why should I trust you?",
		"The Pulse: Because you feel it too. The system is suffocating."
	]
	dialogue_manager.show_dialogue(dialogue, funcref(self, "start_act3_scene1"))

func start_act3_scene1():
	var dialogue = [
		{"choices": [
			{"text": "Obey Broker", "next": ["Broker: You are my asset. Do not betray your purpose.", funcref(self, "set_branch_broker")]},
			{"text": "Help The Pulse", "next": ["The Pulse: Together, we can free the Core.", funcref(self, "set_branch_pulse")]}]}]
	dialogue_manager.show_dialogue(dialogue)

func set_branch_broker():
	branch = "broker"
	start_act3_scene2()

func set_branch_pulse():
	branch = "pulse"
	start_act3_scene2()

func start_act3_scene2():
	var pre = ["Broker: You leave me no choice."]
	# TODO: Start security breach level
	var post = ["GL-1N3: Why are you doing this?", "Broker: It’s for the system’s stability."]
	dialogue_manager.show_dialogue(pre + post, funcref(self, "start_act3_scene3"))

func start_act3_scene3():
	var dialogue = ["The Pulse: This is our only chance. Go!"]
	dialogue_manager.show_dialogue(dialogue, funcref(self, "start_act4_scene1"))

func start_act4_scene1():
	var dialogue = [
		"Broker: Don’t do this. I can’t lose control.",
		"GL-1N3: I have to try."
	]
	# TODO: Final race/collapse effects
	dialogue_manager.show_dialogue(dialogue, funcref(self, "start_act4_scene2"))

func start_act4_scene2():
	var dialogue = []
	if branch == "broker":
		dialogue = ["GL-1N3 delivers the patch, but Broker regains control.", "Broker: GL-1N3...? What happened?", "GL-1N3: Welcome back, Broker."]
	else:
		dialogue = ["The Pulse: You did it. The Core is free.", "Broker (rebooting): GL-1N3...? What happened?", "GL-1N3: Welcome back, Broker."]
	dialogue_manager.show_dialogue(dialogue, funcref(self, "start_act4_scene3"))

func start_act4_scene3():
	var dialogue = []
	if branch == "broker":
		dialogue = ["Broker: Thank you, GL-1N3."]
	else:
		dialogue = ["The Pulse: You are more than data. You are hope.", "Broker: Thank you, GL-1N3."]
	dialogue_manager.show_dialogue(dialogue)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		dialogue_manager.advance()

func _process(delta):
	for hazard in get_tree().get_nodes_in_group("hazards"):
		if player.global_position.distance_to(hazard.global_position) < 36:
			# Player hit hazard, restart scene
			hazard_timer.stop()
			for h in get_tree().get_nodes_in_group("hazards"):
				h.queue_free()
				# Optionally, play a hit effect
			dialogue_manager.show_dialogue(["GL-1N3: System error!"], funcref(self, "start_act2_scene2"))
			return
