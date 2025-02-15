extends Area3D
@onready var game_manager = get_node("/root/Main/GameManager")
var current_npc
# called when a body enters our collider
func _on_body_entered(body):
	print("Checking if NPC nearby...")
	if body.is_in_group("NPC"):
		print("NPC registered in radius")
		current_npc = body
# called when a body exits our collider
func _on_body_exited(body):
	if current_npc == body:
		current_npc = null
# called when an input is detected
func _input(event):
	#print("I am in event")
	# did we press F and we are currently not in dialogue?
	#print(game_manager.is_dialogue_active())
	if game_manager.is_dialogue_active() == false:
		if current_npc != null:
			print("dialogue is not active")
			if Input.is_key_pressed(KEY_F):
			#if we have a current NPC, enter into dialogue with them
					print("current npc is not null")
					game_manager.enter_new_dialogue(current_npc)
					current_npc.stop_animation()
				  # Stop movement
			#else: 
				#print("dialogue inactive, so restarting agent motion.")
				
