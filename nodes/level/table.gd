extends StaticBody


var state = global.TableState.ACTIVE
var _timeToDeath = 10;

# Initial state
func _ready():
	global.tables.append(self);
	_timeToDeath = rand_range(global.tableDeathTimeMin, global.tableDeathTimeMax);
	$smokeParticles.emitting = false;
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.state == global.TableState.ACTIVE:
		_timeToDeath -= delta;
		if(_timeToDeath < 0):
			setState(global.TableState.BROKEN);

func setState(state):
	self.state = state;
	if state == global.TableState.ACTIVE:
		$smokeParticles.emitting = false;
		_timeToDeath = rand_range(global.tableDeathTimeMin, global.tableDeathTimeMax);
	elif state == global.TableState.BROKEN:
		$smokeParticles.emitting = true;

	print("State set to ", state);

#
# Should trigger when player enters the trigger zone
#
func _on_trigger_area_entered(area):
	print("player trigger entered");
	global.activeTable = self;

func _on_trigger_area_exited(area):
	print("player trigger exited");
	global.activeTable = null;
