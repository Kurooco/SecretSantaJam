extends Node3D

func _ready():
	$Sprite3D.modulate = Color.TRANSPARENT

func _on_dialogic_signal_handler_matched():
	var tween : Tween = create_tween()
	tween.tween_property($Sprite3D, "modulate", Color.WHITE, 2)


func _on_dialogic_signal_handler_2_matched():
	var tween : Tween = create_tween()
	tween.tween_property($Sprite3D, "modulate", Color.TRANSPARENT, 2)
