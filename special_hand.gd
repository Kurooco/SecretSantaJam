extends "res://hand.gd"

var origin_position : Vector3
@export var travel_position : Vector3
@export var pi_guy : Node

func _ready():
	origin_position = position
	Dialogic.signal_event.connect(do_animation)

func do_animation(arg):
	if(!arg is String): 
		return
	if(arg == "hand1"):
		var t : Tween = create_tween()
		t.tween_property(self, "position", travel_position, 3)
		await t.finished
		await get_tree().create_timer(1.0).timeout
		close()
	if(arg == "hand2"):
		var t : Tween = create_tween()
		t.tween_property(self, "position", origin_position, 2)
		t.parallel().tween_property(pi_guy, "position", origin_position, 2)
		await t.finished
		hide()
		pi_guy.hide()
