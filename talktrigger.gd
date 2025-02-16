extends Area2D
@onready var game_manager = get_node("/root/Main/GameManager")
var current_npc
# called when a body enters our collider
func _on_body_entered(body):
if body.is_in_group("NPC"):
current_npc = body
# called when a body exits our collider
func _on_body_exited(body):
if current_npc == body:
