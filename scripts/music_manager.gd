extends Node

onready var music_player = AudioStreamPlayer.new()

func _ready():
	add_child(music_player)
	play_music()

func play_music():
	var music_path = "res://music/track1.ogg"
	if ResourceLoader.exists(music_path):
		music_player.stream = load(music_path)
		music_player.play()
