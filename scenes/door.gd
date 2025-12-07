extends Sprite3D

@export var level : PackedScene

func _on_interaction_area_activated():
	Autoload.level_handler.set_level(level)
