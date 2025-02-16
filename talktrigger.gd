extends Area3D
@onready var game_manager = get_node("/root/Main/GameManager")
var current_npc
# called when a body enters our collider
func _on_body_entered(body):
	if body.is_in_group("NPC"):
		current_npc = body
# called when a body exits our collider
func _on_body_exited(body):
	if current_npc == body:
		current_npc = null
# called when an input is detected
func _input(event):
	# did we press F and we are currently not in dialogue?
	if Input.is_key_pressed(KEY_F) and game_manager.is_dialogue_active() == false:
	# if we have a current NPC, enter into dialogue with them
		if current_npc != null:
			game_manager.enter_new_dialogue(current_npc)
