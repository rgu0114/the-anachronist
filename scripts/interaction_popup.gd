# interaction_popup.gd
extends Control

@onready var label = $Label

func _ready():
	hide()  # Start hidden

func show_popup(npc_name: String):
	label.text = "Press F to talk to " + npc_name
	show()

func hide_popup():
	hide()
