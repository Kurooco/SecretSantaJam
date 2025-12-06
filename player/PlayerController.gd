extends Node3D

var h_rads = 0
var v_rads = 0
var first_person = false
var height
var mouse_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	height = $CameraPivot.position.y

func _input(event: InputEvent):
	if (Input.mouse_mode != Input.MOUSE_MODE_CAPTURED) and event is InputEventMouseButton: 
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if(event is InputEventMouseMotion):
		mouse_position += event.relative
		var viewport_size = get_viewport().size
		mouse_position = Vector2(int(mouse_position.x) % viewport_size.x, max(min(mouse_position.y, viewport_size.y/2.0), 20))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("ui_cancel")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	h_rads = -mouse_position.x*2*PI/get_viewport().size.x
	v_rads = mouse_position.y*2*PI/get_viewport().size.y
	v_rads = max(0, v_rads)
	var b = Basis()
	
	b.y.z = cos(v_rads)
	b.y.y = sin(v_rads)
	b.z.z = cos(v_rads - PI/2)
	b.z.y = sin(v_rads - PI/2)
	
	var zz_mag = b.z.z
	var yz_mag = b.y.z
	b.y.x = sin(h_rads) * yz_mag
	b.y.z = cos(h_rads) * yz_mag
	b.z.x = sin(h_rads) * zz_mag
	b.z.z = cos(h_rads) * zz_mag
	# Use these for movement
	b.x.x = sin(h_rads + PI/2)
	b.x.z = cos(h_rads + PI/2)
	
	$Player.move_vec_x = Vector2(b.x.x, b.x.z)
	$Player.move_vec_z = Vector2(sin(h_rads), cos(h_rads))
	
	$CameraPivot.transform.basis = b
	$CameraPivot.global_position = lerp($CameraPivot.global_position, $Player.global_position+Vector3(0, height, 0), 1) #.05
	
	
		
