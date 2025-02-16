extends VideoStreamPlayer

func _ready() -> void:
	finished.connect(_on_finished)
	
func _on_finished():
	print("on finished")
	hide()
	get_tree().paused = false
	z_index = -100
	queue_free()
	
