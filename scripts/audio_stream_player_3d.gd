extends AudioStreamPlayer3D

func _ready() -> void:
	# Get reference to the VideoStreamPlayer
	var video_player = get_node("../VideoStreamPlayer")
	if video_player:
		video_player.video_ended.connect(_on_video_ended)
		
	# Load the audio file
	var audio = load("res://instructions.mp3")
	stream = audio
	
func _on_video_ended():
	play()
