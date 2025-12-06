extends Node3D

var h_rads = 0
var v_rads = 0
var first_person = false
var height

# Called when the node enters the scene tree for the first time.
func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	height = $CameraPivot.position.y

func _input(event: InputEvent):
	if (Input.mouse_mode != Input.MOUSE_MODE_CAPTURED) and event is InputEventMouseButton: 
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(Input.mouse_mode == Input.MOUSE_MODE_HIDDEN):
		var mouse = get_viewport().get_mouse_position()
		var viewport_size = get_viewport().size
		#get_viewport().warp_mouse(Vector2(int(mouse.x+viewport_size.x) % viewport_size.x, int(mouse.y+viewport_size.y) % viewport_size.y))
		#get_viewport().warp_mouse(Vector2(int(mouse.x+viewport_size.x) % viewport_size.x, max(min(mouse.y, viewport_size.y/2.0), 20)))
	if(Input.is_action_pressed("ui_cancel")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if(Input.is_action_pressed("ui_accept")):
		get_tree().quit()
		
	#if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
	#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	h_rads = -get_viewport().get_mouse_position().x*2*PI/get_viewport().size.x
	v_rads = get_viewport().get_mouse_position().y*2*PI/get_viewport().size.y
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
	
	
		
