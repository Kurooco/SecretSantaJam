extends Node3D

func _ready():
	await get_tree().create_timer(3.0).timeout
	close()

func close():
	for child in get_children():
		if(child.has_method("close")):
			child.close()
