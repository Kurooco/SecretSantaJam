extends Sprite3D

@export var level : PackedScene
@export var disabled : bool

func _ready():
	$InteractionArea.disabled = disabled

func _on_interaction_area_activated():
	Autoload.level_handler.set_level(level)
