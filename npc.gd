extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var move_speed = 2.0
var rotation_speed = 2.0
var change_direction_time = 3.0  # Time before changing direction
var timer = 0.0
var current_direction = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Start walking animation
	if animation_player.has_animation("Walking"):
		animation_player.play("Walking")
	
	# Set initial random direction
	randomize()
	change_direction()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Update timer
	timer += delta
	
	# Change direction after time expires
	if timer >= change_direction_time:
		change_direction()
		timer = 0.0
	
	# Move in current direction
	global_translate(current_direction * move_speed * delta)
	
	# Rotate to face movement direction
	if current_direction != Vector3.ZERO:
		var target_rotation = atan2(current_direction.x, current_direction.z)
		var current_rotation = rotation.y
		
		# Smoothly interpolate rotation
		rotation.y = lerp_angle(current_rotation, target_rotation, rotation_speed * delta)

func change_direction() -> void:
	# Generate random angle between 0 and 2π
	var random_angle = randf_range(0, PI * 2)
	
	# Convert angle to direction vector
	current_direction = Vector3(
		sin(random_angle),
		0,
		cos(random_angle)
	).normalized()

# Optional: Add this function to handle collision with walls/obstacles
func _on_area_3d_body_entered(body: Node3D) -> void:
	# Reverse direction if we hit something
	current_direction = -current_direction
	timer = change_direction_time  # This will trigger a new direction next frame
