extends Node3D

var dist_from_origin = 0.0
var origin_position : Vector3
var move_direction : Vector3
@export var advance_speed = 5.0
@export var retreat_speed = 2.0

func _ready():
	move_direction = transform.basis.z
	origin_position = position

func _process(delta):
	var col = $RayCast3D.get_collider()
	var dist = $RayCast3D.get_collision_point().distance_to(position)
	if(is_instance_valid(col) && col.is_in_group("hand_detection")):
		if(dist > 1):
			advance(delta*advance_speed)
	else:
		retreat(delta*retreat_speed)

func advance(s):
	position += move_direction*s
	dist_from_origin += s

func retreat(s):
	position -= move_direction*s
	dist_from_origin -= s
	if(dist_from_origin <= 0):
		position = origin_position
		dist_from_origin = 0


func _on_interaction_area_activated():
	get_tree().get_first_node_in_group("player").disabled = true
	$Hand.close()
	await get_tree().create_timer(1).timeout
	Autoload.level_handler.restart()
