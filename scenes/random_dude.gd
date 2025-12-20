extends Sprite3D


func _ready():
	visible = Autoload.level_handler.e_route < 1
	$DialogueArea.disabled = Autoload.level_handler.e_route == 1
