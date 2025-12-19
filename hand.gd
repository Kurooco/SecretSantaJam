extends Node3D

@export var override_speed = false
@export var override_bottom = 1.0
@export var override_top = 1.0
@export var override_amount = 1.0


func close():
	for child in get_children():
		if(child.has_method("close")):
			if(override_speed):
				child.top_speed = override_top
				child.bottom_speed = override_bottom
				child.amount = override_amount
			child.close()
