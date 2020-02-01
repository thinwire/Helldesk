extends Node

#
# Game world control stuff
#


func _ready():
	global.player = $player
	
	pass

func _process(delta):
	
	if(Input.is_action_just_pressed("ui_accept")):
		print("activate table ", global.activeTable)
		
		if(global.activeTable != null):
			# Fix current table
			global.activeTable.setState(global.TableState.ACTIVE);
	
	
	
	pass
