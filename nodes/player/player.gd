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
	print($trigger)
	
	# start animations
	var anim = $wizard.find_node("animations");
	anim["parameters/transition/current"] = "idle";
	
	var ap: AnimationPlayer = $wizard.find_node("AnimationPlayer");
	#ap.get_animation("wizard_idle").set_loop(true);
	#ap.get_animation("wizard_walk").set_loop(true);
	#ap.get_animation("wizard_extinguisher").set_loop(true);


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
	
func handle_animation(speed):
	var s = min(speed.length(), (_lastPos - self.translation).length());
		
	if(s > 0.5):
		$wizard.walk(speed.length() * 0.43);
	else:
		$wizard.idle();	
	
	# Turn wizard to face in movement direction
	if(s > 1):
		var target_dir = atan2(speed.x, speed.z);
		direction += wrapf((target_dir - direction), -PI, PI) * 0.3;
	
	$wizard.rotation.y = wrapf(direction, -PI, PI);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_movement(delta);
	var speed = move_and_slide(velocity);
	handle_animation(speed);
	
	if Input.is_action_pressed("ui_accept"):
		$wizard.extinguish();
	
