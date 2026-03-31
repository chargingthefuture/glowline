extends Node

# DialogueManager handles displaying dialogue and branching choices
var dialogue_queue = []
var current_dialogue = null
var dialogue_box = null
var choice_box = null
var callback = null

func _ready():
	# Assume dialogue_box and choice_box are children
	dialogue_box = $DialogueBox
	choice_box = $ChoiceBox
	dialogue_box.hide()
	choice_box.hide()

func show_dialogue(dialogue: Array, on_complete = null):
	dialogue_queue = dialogue.duplicate()
	callback = on_complete
	_show_next()

func _show_next():
	if dialogue_queue.size() == 0:
		dialogue_box.hide()
		choice_box.hide()
		if callback:
			callback.call()
		return
	current_dialogue = dialogue_queue.pop_front()
	if typeof(current_dialogue) == TYPE_DICTIONARY and current_dialogue.has("choices"):
		_show_choices(current_dialogue["choices"])
	else:
		_show_line(current_dialogue)

func _show_line(line):
	dialogue_box.text = line
	dialogue_box.show()
	choice_box.hide()

func _show_choices(choices: Array):
	choice_box.clear()
	for c in choices:
		choice_box.add_item(c["text"])
	choice_box.show()
	choice_box.connect("item_selected", self, "_on_choice_selected", [choices])
	dialogue_box.hide()

func _on_choice_selected(idx, choices):
	choice_box.disconnect("item_selected", self, "_on_choice_selected")
	var chosen = choices[idx]
	if chosen.has("next"):
		show_dialogue(chosen["next"], callback)
	else:
		_show_next()

func advance():
	if dialogue_box.visible:
		_show_next()