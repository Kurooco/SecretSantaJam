extends Node3D

func _ready():
	var children = $Cement.get_children().duplicate()
	for child in children:
		if(child is MeshInstance3D && child.visible):
			var col = CollisionShape3D.new()
			col.shape = BoxShape3D.new()
			col.shape.size = child.mesh.size*abs(child.scale)
			col.position = child.position
			col.rotation = child.rotation
			$Cement.add_child(col)


func _on_interaction_area_activated():
	print("works!")
