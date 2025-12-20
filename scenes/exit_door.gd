extends Sprite3D

var origin_position

func _ready():
	origin_position = position
	position += Vector3(0, 1000, 0)

func _on_interaction_area_activated():
	Autoload.level_handler.set_level(load("res://scenes/the_end.tscn"))


func _on_dialogic_signal_handler_matched():
	var tween : Tween = create_tween()
	tween.tween_property(self, "position", origin_position, 5).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
