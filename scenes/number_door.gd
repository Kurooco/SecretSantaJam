@tool
extends Sprite3D

@export var number : int : 
	set(num):
		$Label3D.text = str(num)
		number = num

func _ready():
	if(!Engine.is_editor_hint()):
		$Label3D.hide()
		$LabelMesh.mesh = TextMesh.new()
		$LabelMesh.mesh.text = str(number)
		$LabelMesh.mesh.font_size = 100
		$LabelMesh.show()

func _on_interaction_area_activated():
	Autoload.level_handler.submit_number(number)
