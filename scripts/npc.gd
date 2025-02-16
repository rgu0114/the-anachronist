extends CharacterBody3D
class_name NPC 

@export var icon : Texture
@export var character: String
@export_multiline var prompt : String
@export_multiline var character_system_prompt : String

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var move_speed = randf_range(0.8, 1.3)
var rotation_speed = 1.0	
var change_direction_time = randf_range(6.0, 11.0)  # Time before changing direction
var timer = 0.0
var current_direction = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Animation player found:", animation_player != null)
	print("Available animations:", animation_player.get_animation_list())
	
	if animation_player.has_animation("Armature|walking_man|baselayer"):
		print("animation found!")
		# Set animation to loop
		var anim = animation_player.get_animation("Armature|walking_man|baselayer")
		anim.loop_mode = Animation.LOOP_LINEAR
		# Play the animation
		animation_player.play("Armature|walking_man|baselayer", -1, 1.0)
	
	randomize()
	change_direction()

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

func _on_body_entered(body):
	if body is StaticBody3D:
		current_direction = -current_direction
		timer = change_direction_time

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

# Stops all animations on the NPC.
func stop_animation() -> void:
	animation_player.stop()
	move_speed = 0
	rotation_speed = 0

# Starts (or restarts) the default walking animation.
func start_animation() -> void:
	var anim_name = "Armature|walking_man|baselayer"
	if animation_player.has_animation(anim_name):
		# Set the animation to loop (if needed)
		var anim = animation_player.get_animation(anim_name)
		anim.loop_mode = Animation.LOOP_LINEAR
		animation_player.play(anim_name, -1, 1.0)
	else:
		print("Animation", anim_name, "not found!")
