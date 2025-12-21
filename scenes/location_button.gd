extends Button

@export var location : String
@export var fade : bool

func _on_pressed():
	Autoload.level_handler.set_level(load(location), fade)
	disabled = true
