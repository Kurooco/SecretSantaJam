extends CanvasLayer


func _on_button_pressed():
	$AudioStreamPlayer.play()
	Autoload.level_handler.set_level(load("res://scenes/world.tscn"))


func _on_button_mouse_entered():
	$AudioStreamPlayer.play()
