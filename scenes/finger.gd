extends Node3D

var closing = false
@onready var bottom = $Bottom
@onready var top = $Bottom/Node/Top
@onready var top_joint = $Bottom/TopJoint
@export var top_speed : float = 1.5
@export var bottom_speed : float = 1.0
var angle = -1
var amount = 1


func close():
	closing = true
	
func _process(delta):
	var a = angle*delta
	if(closing && amount > 0):
		amount -= abs(a)
		bottom.rotate(Vector3(1, 0, 0), -a*bottom_speed)
		top_joint.rotate(Vector3(1, 0, 0), -a*top_speed)
		"""bottom.transform *= Transform3D(
			Vector3(1, 0, 0),
			Vector3(0, cos(a), -sin(a)),
			Vector3(0, sin(a), cos(a)),
			Vector3(0, 0, 0),
		)"""
