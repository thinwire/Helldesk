extends StaticBody

const timeToAngryMin = 30;
const timeToAngryMax = 120;

const timeToBreakMin = 15;
const timeToBreakMax = 45;

const breakageSpeedMin = 0.03;	# How many points per second, at least, computer starts breaking
const breakageSpeedMax = 0.16;  # How many points per second, at most, computer starts breaking
const maxBreakage      = 3;  	# How broken can a computer be, max?

enum State {
	WORKING,
	ANGRY,
	BROKEN
}
var _state = State.WORKING;

var _timeToAngry = 10;
var _timeToBreak = 10;

var _breakageSpeed = 0.2;
var _breakage      = 0;
var _fixing        = false;
var _targeted      = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if _state == State.WORKING:
		_timeToAngry -= delta;
		if _timeToAngry < 0:
			setState(State.ANGRY);
	elif _state == State.ANGRY:
		_timeToBreak -= delta;
		if _timeToBreak < 0:
			setState(State.BROKEN);
	else:
		# Handle player life loss
		pass
	
	if Input.is_action_pressed("ui_accept") && _targeted:
		fix(delta);
	
	# Users break computers
	if _fixing == false:
		if _state == State.ANGRY:
			_breakage += _breakageSpeed * 0.5 * delta;
		if _state == State.BROKEN:
			_breakage += _breakageSpeed * 0.9 * delta;
	
	_breakage = clamp(_breakage, 0, maxBreakage);
	_fixing   = false;
	

func setState(state):
	_state = state;
	if state == State.WORKING:
		_timeToAngry    = rand_range(timeToAngryMin,   timeToAngryMax);
		_timeToBreak    = rand_range(timeToBreakMin,   timeToBreakMax);
		_breakageSpeed  = rand_range(breakageSpeedMin, breakageSpeedMax);
		_breakage       = 0;
		$smoke.emitting = false;
		$fire.emitting  = false;
		$caveman.idle();
	
	elif state == State.ANGRY:
		$smoke.emitting = true;
		$fire.emitting  = false;
		$caveman.angry();
			
	elif state == State.BROKEN:
		$smoke.emitting = true;
		$fire.emitting  = true;
		$caveman.smash();

func fix(delta):
	_fixing = true;
	_breakage -= delta;

	if _breakage <= 1.0 && _breakage > 0.0:
		setState(State.ANGRY);
	if _breakage < 0.0:
		setState(State.WORKING);

func isBroken():
	return _state == State.BROKEN;

#
# Should trigger when player enters the trigger zone
#
func _on_trigger_area_entered(area):
	print("player trigger entered ", self);
	_targeted = true;
	

func _on_trigger_area_exited(area):
	print("player trigger exited ", self);
	_targeted = false;
	

func _ready():
	global.tables.append(self);
	setState(State.WORKING);
	_targeted = false;
