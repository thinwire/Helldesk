extends Camera

const height = 8;
const distance = 6;

func _ready():
	pass # Replace with function body.

func _process(delta):
	var player = global.player;
	var p = player.translation;
	var from = Vector3(p.x, p.y + height, p.z + distance) - player.velocity * 0.1;
	self.translation = from;
	self.look_at(p, Vector3.UP);
