extends Node3D

func _ready():
	var children = $Cement.get_children().duplicate()
	for child in children:
		if(child is MeshInstance3D && child.visible):
			var col = CollisionShape3D.new()
			col.shape = BoxShape3D.new()
			col.shape.size = child.mesh.size*child.scale
			col.position = child.position
			col.rotation = child.rotation
			$Cement.add_child(col)
"""
var sh = child.shape
		var new_mesh = MeshInstance3D.new()
		var box = BoxMesh.new()
		box.size = sh.size
		new_mesh.mesh = box
		new_mesh.position = child.position
		new_mesh.rotation = child.rotation
		box.material = load("res://art/new_standard_material_3d.tres")
		add_child(new_mesh)
"""
