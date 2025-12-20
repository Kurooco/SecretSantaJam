extends Node

@export var music : String

func _ready():
	MusicHandler.play(music)
