extends Button

@onready var outro_video = $"../OutroVideoStreamPlayer"

var video_player: VideoStreamPlayer

func _ready():
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	print("button pressed")
	outro_video.show()
	outro_video.play()
