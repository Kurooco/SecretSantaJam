extends Sprite3D

@export var number : int

func _ready():
	$Label3D.text = str(number)

func _on_interaction_area_activated():
	Autoload.level_handler.submit_number(number)
