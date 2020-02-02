#
# Crappy movement script v 1.0
#

extends KinematicBody

const velocity = Vector3();
const accel = 45.0;
const decel = 30.0;
const speed = 8.0;
	
const _lastPos = Vector3();
var direction = PI;

# There has to be a builtin for this..
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
	pass;

func handle_movement(delta):
	var dx = 0.0;
	var dz = 0.0;

	var fire = float(Input.is_action_pressed("ui_accept"));
	
	dx -= float(Input.is_action_pressed("ui_left"));
	dx += float(Input.is_action_pressed("ui_right"));
	dz -= float(Input.is_action_pressed("ui_up"));
	dz += float(Input.is_action_pressed("ui_down"));

	if dx == 0.0 || fire != 0.0:
		velocity.x = toZero(velocity.x, decel * delta);
	elif fire == 0.0: 
		velocity.x = clampAbs(velocity.x + dx * accel * delta, speed);
	
	if dz == 0.0 || fire != 0.0: 
		velocity.z = toZero(velocity.z, decel * delta);
	elif fire == 0.0: 
		velocity.z = clampAbs(velocity.z + dz * accel * delta, speed);
	
	var l = clamp(velocity.length(), 0, speed);
	var n = velocity.normalized();
	velocity.x = n.x * l;
	velocity.z = n.z * l;

	var speed = move_and_slide(velocity);
	
	# Turn wizard to face in movement direction
	# (there has to be an easier way to do this, too...)
	var s = min(speed.length(), (_lastPos - self.translation).length());
	var turn = false;
	var target_dir = 0.0;
	if s > 1.0:
		target_dir = atan2(speed.x, speed.z);
		turn = true;
	elif dx != dz || dx != 0.0:
		target_dir = atan2(dx, dz);
		turn = true;
	if turn:
		direction += wrapf((target_dir - direction), -PI, PI) * 0.3;
	
	$wizard.rotation.y = wrapf(direction, -PI, PI);
	return speed;

	
func handle_animation(speed):
	var s = speed.length();
	if(s > 0.1):
		$wizard.walk(s * 0.43);
	else:
		$wizard.idle();		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = handle_movement(delta);
	handle_animation(speed);
	
	# Show extinguisher effect
	# Actual fixing of table is handled in the tables themselves now
	# Because that's not fucky at all
	if Input.is_action_pressed("ui_accept"):
		$wizard.extinguish();
		
