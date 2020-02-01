extends Node

#
# Game world control stuff
#


func _ready():
	global.player = find_node("player")
	
	pass

func _process(delta):
	
	if(Input.is_action_pressed("ui_accept")):
		print("activate table", global.activeTable)
	
	pass
