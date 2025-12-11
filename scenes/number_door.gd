@tool
extends Sprite3D

@export var number : int : 
	set(num):
		$Label3D.text = str(num)
		number = num

func _ready():
	$Label3D.text = str(number)

func _on_interaction_area_activated():
	Autoload.level_handler.submit_number(number)
