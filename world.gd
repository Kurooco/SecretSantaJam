extends Node3D

func _ready():
	for child : CollisionShape3D in $Cement.get_children():
		var sh = child.shape
		var new_mesh = MeshInstance3D.new()
		var box = BoxMesh.new()
		box.size = sh.size
		new_mesh.mesh = box
		new_mesh.position = child.position
		new_mesh.rotation = child.rotation
		box.material = load("res://art/new_standard_material_3d.tres")
		add_child(new_mesh)
