extends Node
var api_key : String = ""
var url : String = "https://api.openai.com/v1/chat/completions"
var temperature : float = 0.5
var max_tokens : int = 1024
var headers = ["Content-type: application/json", "Authorization: Bearer " + api_key]
var model : String = "gpt-4o-mini"
var messages = []
var request : HTTPRequest
@onready var dialogue_box = get_node("/root/Main/CanvasLayer/DialogueBox")
var current_npc
@export_multiline var dialogue_rules : String

signal on_player_talk
signal on_npc_talk (npc_dialogue)

func _ready ():
	request = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed", _on_request_completed)
# called when we want to talk to the AI
func dialogue_request (player_dialogue):
	var prompt = player_dialogue
	if len(messages) == 0:
		print("First message... inputting system prompt")
		print("Character Name", current_npc.character)
		var header_prompt = current_npc.character_system_prompt
		messages.append({
		"role": "system",
		"content": header_prompt
		})
# add a new message to the array
	messages.append({
	"role": "user",
	"content": prompt
	})
	on_player_talk.emit()	
	# create the request body
	var body = JSON.new().stringify({
	"messages": messages,
	"temperature": temperature,
	"max_tokens": max_tokens,
	"model": model
	})
	# send the request to the AI server
	print("Sending body to server", body)
	var send_request = request.request(url, headers, HTTPClient.METHOD_POST, body)
	# if there was a problem, make it known
	if send_request != OK:
		print("There was an error!")
# called when we have received a response from the server
func _on_request_completed (result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	var message = response["choices"][0]["message"]["content"]
	messages.append({
	"role": "assistant",
	"content": message
	})
	on_npc_talk.emit(message)
# called when we begin talking with an NPC
func enter_new_dialogue (npc):
	current_npc = npc
	messages = []
	dialogue_box.visible = true
	dialogue_box.initialize_with_npc(current_npc)
	dialogue_request("")
# called when we stop talking with an NPC
func exit_dialogue ():
	current_npc = null
	messages = []
	dialogue_box.visible = false
# are we currently talking? True or False
func is_dialogue_active ():
	return dialogue_box.visible
