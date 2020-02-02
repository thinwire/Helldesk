extends StaticBody

const timeToBreakMin = 70;
const timeToBreakMax = 320;

const breakageSpeedMin = 0.03;  # How many points per second, at least, computer starts breaking
const breakageSpeedMax = 0.16;  # How many points per second, at most, computer starts breaking
const maxBreakage      = 2.5;   # How broken can a computer be, max?

enum State {
	WORKING,
	BROKEN
}
var _state = State.WORKING;

var _timeToBreak   = 10;
var _breakageSpeed = 0.2;
var _breakage      = 0;
var _fixing        = false;
var _targeted      = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Don't proc if we're not supposed to run yet
	if global.running == false:
		return;
	
	if _state == State.WORKING:
		_timeToBreak -= delta;
		if _timeToBreak < 0:
			setState(State.BROKEN);
	
	if Input.is_action_pressed("ui_accept") && _targeted:
		fix(delta);
	
	if _fixing == false:
		if _state == State.BROKEN:
			_breakage += _breakageSpeed * 0.9 * delta;
			global.player_health -= 75 * delta;
	
	_breakage = clamp(_breakage, 0, maxBreakage);
	_fixing   = false;
	

func setState(state):
	_state = state;
	if state == State.WORKING:
		_timeToBreak    = rand_range(timeToBreakMin,   timeToBreakMax);
		_breakageSpeed  = rand_range(breakageSpeedMin, breakageSpeedMax);
		_breakage       = 0;
		$smoke.emitting = false;
		$fire.emitting  = false;
			
	elif state == State.BROKEN:
		$smoke.emitting = true;
		$fire.emitting  = true;

func fix(delta):
	_fixing = true;
	_breakage -= delta;

	if _breakage < 0.0:
		setState(State.WORKING);

func isBroken():
	return _state == State.BROKEN;

#
# Should trigger when player enters the trigger zone
#
func _on_trigger_area_entered(_area):
	print("player trigger entered ", self);
	_targeted = true;
	

func _on_trigger_area_exited(_area):
	print("player trigger exited ", self);
	_targeted = false;
	

func _ready():
	global.servers.append(self);
	_targeted = false;
	_fixing = false;
	setState(State.WORKING);
