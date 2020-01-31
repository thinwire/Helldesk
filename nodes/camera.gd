extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = get_parent().find_node("player");

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var p = player.translation;
	self.translation.x = p.x;
	self.translation.y = p.y + 4;
	self.translation.z = p.z + 10;
	
	pass
