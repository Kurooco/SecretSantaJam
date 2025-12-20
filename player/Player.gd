extends CharacterBody3D


const SPEED = 8.0
const RUN_SPEED = 15.0
const JUMP_VELOCITY = 14.5

var move_vec_x = Vector2(1, 0)
var move_vec_z = Vector2(1, 0)
var disabled = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if !disabled && Input.is_action_just_pressed("ui_accept") and is_on_floor() and Dialogic.current_timeline == null:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var speed = RUN_SPEED if Input.is_action_pressed("run") else SPEED
	if direction and Dialogic.current_timeline == null and !disabled:
		velocity.x = direction.x * speed * move_vec_x.x
		velocity.z = direction.x * speed * move_vec_x.y
		
		velocity.x += direction.z * speed * move_vec_z.x
		velocity.z += direction.z * speed * move_vec_z.y
		
		"""velocity.x = direction.x * SPEED * move_vec.x
		velocity.z = direction.z * SPEED * move_vec.y"""
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	if(position.y < -1000):
		Autoload.level_handler.restart()
