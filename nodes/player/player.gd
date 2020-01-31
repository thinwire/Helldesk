extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector3();
var accel = 7.0;
var decel = 15.0;

func length(vec):
	var xx = vec.x * vec.x;
	var yy = vec.y * vec.y;
	var zz = vec.z * vec.z;
	return sqrt(xx + yy + zz);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func handle_movement(delta):
	var dx = 0.0;
	var dz = 0.0;
	
	dx -= float(Input.is_action_pressed("ui_left"));
	dx += float(Input.is_action_pressed("ui_right"));
	dz -= float(Input.is_action_pressed("ui_up"));
	dz += float(Input.is_action_pressed("ui_down"));
		
	if dx == 0.0: 
		velocity.x -= decel * sign(velocity.x) * delta;
	else: 
		velocity.x += dx * accel * delta;
	
	if dz == 0.0: 
		velocity.z -= decel * sign(velocity.z) * delta;
	else: 
		velocity.z += dz * accel * delta;
	
	if length(velocity) < 0.1:
		velocity.x = 0;
		velocity.z = 0;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_movement(delta);
	move_and_slide(velocity);
	
