#
# Crappy movement script v 1.0
#

extends KinematicBody

const velocity = Vector3();
const accel = 45.0;
const decel = 30.0;
const speed = 8.0;
	
func toZero(num, amount):
	if num > 0: 
		num -= amount;
		if num < 0: 
			num = 0;
	else:
		num += amount;
		if num > 0:
			num = 0;
	return num;
	
func clampAbs(num, lim):
	return min(abs(num), lim) * sign(num);

# Called when the node enters the scene tree for the first time.
func _ready():
	print($trigger)
	pass # Replace with function body.

func handle_movement(delta):
	var dx = 0.0;
	var dz = 0.0;
	
	dx -= float(Input.is_action_pressed("ui_left"));
	dx += float(Input.is_action_pressed("ui_right"));
	dz -= float(Input.is_action_pressed("ui_up"));
	dz += float(Input.is_action_pressed("ui_down"));

	if (dx == 0.0): 
		velocity.x = toZero(velocity.x, decel * delta);
	else: 
		velocity.x = clampAbs(velocity.x + dx * accel * delta, speed);
		
	if (dz == 0.0): 
		velocity.z = toZero(velocity.z, decel * delta);
	else:
		velocity.z = clampAbs(velocity.z + dz * accel * delta, speed);
		
	var l = clamp(velocity.length(), 0, speed);
	var n = velocity.normalized();
	velocity.x = n.x * l;
	velocity.z = n.z * l;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_movement(delta);
	move_and_slide(velocity);
	
	#
	# Detect player hitting wall
	# unused for now
	#
	var c = get_slide_count();
	#if(c > 0):
	#	print("player hit obstacle")
	
