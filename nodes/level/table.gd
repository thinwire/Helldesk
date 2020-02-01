extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#
# Should trigger when player enters the trigger zone
#
func _on_trigger_area_entered(area):
	print("player trigger entered");
	
	global.activeTable = self;
	
	print(area);
	
	pass # Replace with function body.

func _on_trigger_area_exited(area):
	print("player trigger exited");
	
	global.activeTable = null;
	
	print(area);
	
	pass # Replace with function body.
