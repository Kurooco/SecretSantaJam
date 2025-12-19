extends Node

@export var first_scene : PackedScene
@onready var fade = $FadeCanvas/Fade
var current_level = null
var fade_tween : Tween = null

var digit_order = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
@export var room_order : Array[PackedScene]
var current_digit = 0

signal fade_ended
signal level_set

func _ready():
	Autoload.level_handler = self
	set_level(first_scene, false)
	MusicHandler.play("res://sounds/music/Creepy Ambience (Damp).wav")
	
func set_level(scene: PackedScene, fade = true):
	if(fade):
		fade_out()
		await fade_ended
		
	if(is_instance_valid(current_level)):
		remove_child(current_level)
		current_level.queue_free()
	current_level = scene.instantiate()
	add_child(current_level)
	level_set.emit()
	
	if(fade):
		fade_in()

func fade_out(color=Color.BLACK):
	if(is_instance_valid(fade_tween)):
		fade_tween.kill()
	fade_tween = create_tween()
	fade_tween.tween_property(fade, "color", color, 1)
	fade_tween.tween_callback(fade_ended.emit)

func fade_in():
	var transparent_color = Color(fade.color.r, fade.color.g, fade.color.b, 0)
	if(is_instance_valid(fade_tween)):
		fade_tween.kill()
	fade_tween = create_tween()
	fade_tween.tween_property(fade, "color", transparent_color, 1)
	fade_tween.tween_callback(fade_ended.emit)

func submit_number(num:int):
	if(num == digit_order[current_digit]):
		current_digit += 1;
	else:
		current_digit = 0
	set_level(room_order[current_digit])
