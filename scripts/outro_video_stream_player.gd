extends VideoStreamPlayer

func _ready() -> void:
	hide()
	finished.connect(_on_finished)
	z_index = 100
	
func _on_finished():
	stop()
	print("on finished")
	hide()
	get_tree().paused = false
	z_index = -100
	queue_free()
	
