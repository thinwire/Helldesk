extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var _extinguisher: Node = find_node("extinguisher");
onready var _extParticles: CPUParticles = find_node("extinguisherParticles");

# Called when the node enters the scene tree for the first time.
func _ready():
	$animations["parameters/transition/current"] = 0;
	
	pass # Replace with function body.

func idle():
	_extinguisher.visible = false;
	_extParticles.emitting = false;
	$animations["parameters/transition/current"] = 0;

func walk(speed: float):
	_extinguisher.visible = false;
	_extParticles.emitting = false;
	$animations["parameters/walk_speed/scale"] = speed;
	$animations["parameters/transition/current"] = 1;

func extinguish():
	_extinguisher.visible = true;
	_extParticles.emitting = true;
	$animations["parameters/transition/current"] = 2;
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
