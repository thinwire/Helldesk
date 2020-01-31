extends Camera

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = get_parent().find_node("player");

var height = 8;
var distance = 6;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var p = player.translation;
	var from = Vector3(p.x, p.y + height, p.z + distance) - player.velocity * 0.1;
	#self.look_at_from_position(p, p, Vector3.UP);
	self.translation = from;
	self.look_at(p, Vector3.UP);
