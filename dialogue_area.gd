extends InteractionArea

@export var timeline : String


func _on_activated():
	if(Dialogic.current_timeline == null):
		Dialogic.start(timeline)
