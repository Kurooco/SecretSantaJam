extends Node

@export var first_scene : PackedScene
@onready var fade = $FadeCanvas/Fade
var current_level = null
var fade_tween : Tween = null
var restarting = false

var digit_order   = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3]
var e_digit_order = [2, 7, 1, 8, 2, 8, 1, 8]
@export var room_order : Array[PackedScene]
var current_digit = 0
var e_route = 0

signal fade_ended
signal level_set

func _ready():
	Autoload.level_handler = self
	set_level(first_scene, false)
	
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
	restarting = false
	
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
	#Check e route
	if(current_digit == 0 && e_route == 0):
		e_route = 1 if num == 2 else -1
	
	var order = digit_order if e_route < 1 else e_digit_order
	
	if(current_digit >= order.size() || num == order[current_digit]):
		current_digit += 1;
	else:
		current_digit = 0
		e_route = 0
	
	if(e_route == 1 && current_digit >= e_digit_order.size()):
		set_level(load("res://scenes/e_room.tscn"))
	else:
		set_level(room_order[current_digit])

func restart():
	if(!restarting):
		restarting = true
		if(e_route == 1 && current_digit >= e_digit_order.size()):
			set_level(load("res://scenes/e_room.tscn"))
		else:
			set_level(room_order[current_digit])
