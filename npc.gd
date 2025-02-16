extends CharacterBody3D
class_name NPC 

@export var icon : Texture
@export var character: String
@export_multiline var prompt : String

signal player_entered_range
signal player_exited_range

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var move_speed = 0.0
var rotation_speed = 2.0	
var change_direction_time = 3.0  # Time before changing direction
var timer = 0.0
var current_direction = Vector3.ZERO
var interaction_area: Area3D
var popup: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("NPC ready: ", name);
	add_to_group("npcs")
	
	# Start walking animation
	if animation_player.has_animation("Walking"):
		animation_player.play("Walking")
	
	# Set initial random direction
	randomize()
	change_direction()
	
	var interaction_area = Area3D.new()
	add_child(interaction_area)
	print("Created Area3D for: ", name);
	
	var collision_shape = CollisionShape3D.new()
	var sphere_shape = SphereShape3D.new()
	sphere_shape.radius = 5.0
	collision_shape.shape = sphere_shape
	interaction_area.add_child(collision_shape)
	print("Added collision shape for: ", name)
	
	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)

	# Load and instance the popup
	var popup_scene = load("res://interaction_popup.tscn")
	popup = popup_scene.instantiate()
	add_child(popup)
	popup.hide()
	
func _on_body_entered(body: Node3D):
	print("Something entered NPC area: ", body.name)
	print("Groups of entering body: ", body.get_groups())
	print("Body entered: ", body.name)
	if body.is_in_group("player"):
		print("Player detected in range")
		player_entered_range.emit()
		popup.show_popup(name)

func _on_body_exited(body: Node3D):
	if body.is_in_group("player"):
		print("Player left range")  
		player_exited_range.emit()
		popup.hide_popup()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Update timer
	timer += delta
	
	# Change direction after time expires
	if timer >= change_direction_time:
		change_direction()
		timer = 0.0
	
	# Move in current direction
	#global_translate(current_direction * move_speed * delta)
	
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
