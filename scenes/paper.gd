extends CanvasLayer

@export var enabled = false
var toggled = false
var tween : Tween

@onready var numbers = $Paper/RichTextLabel

func _ready():
	Dialogic.signal_event.connect(enable)
	await get_tree().physics_frame
	Autoload.level_handler.level_set.connect(update)

func _process(delta):
	if(Input.is_action_just_pressed("paper") && enabled):
		update()
		toggle()

func toggle():
	toggled = !toggled
	if(is_instance_valid(tween)):
		tween.kill()
	tween = create_tween()
	var new_position = Vector2($Paper.position.x, -112.0) if toggled else Vector2($Paper.position.x, 500)
	tween.tween_property($Paper, "position", new_position, 1).set_trans(Tween.TRANS_CUBIC)

func update():
	var text = "".join(Autoload.level_handler.digit_order)
	text = text.insert(Autoload.level_handler.current_digit, "[/color]")
	text = text.insert(0, "[color=gray]")
	print_debug(text)
	numbers.text = text

func enable(arg):
	if(arg == "paper"):
		$Label.show()
		enabled = true
		update()
		toggle()
