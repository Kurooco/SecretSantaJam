extends PathFollow3D

@export var interaction_area : InteractionArea
@export var speed : float = 1.0
@export var hide_at_end = false
@export var num : int
var running = false
var p = 0.0

func _ready():
	$NumberDoor.texture = load("res://art/2d/door.png")
	$NumberDoor.set_number(num)
	interaction_area.automatic = true
	interaction_area.show_prompt = false
	interaction_area.one_shot = true
	interaction_area.activated.connect(run)

func run():
	running = true
	$NumberDoor.texture = load("res://art/2d/monkey_door.png")
	
func _process(delta):
	if(running):
		progress_ratio += delta*speed
		if(progress_ratio >= 1 && hide_at_end):
			hide()
