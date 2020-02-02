extends Node

#
# Game world control stuff
#

var fadein: float  = 1.0;
var fadeout: float = 0.0;
var quit: bool     = false;

func _ready():
	global.player = $player	
	fadein  = 1.0;
	fadeout = 0.0;
	quit    = false;

func _process(delta):
	
	# fade screen in. :F
	if fadein > 0.0:
		fadein -= delta * 0.5;
		fadein = max(fadein, 0.0);
		$postprocessLayer/crtshader.get_material().set_shader_param("fade", fadein);
	else:
		global.running = true;
		
	if quit == true:
		if fadeout < 1.0:
			fadeout += delta * 0.5;
			fadeout = min(fadeout, 1.0);
			$postprocessLayer/crtshader.get_material().set_shader_param("fade", fadeout);
		else:
			global.reset();
			get_tree().reload_current_scene();
			quit = false;
	
	
	if Input.is_action_just_pressed("ui_cancel"):
		quit = true;

	if global.player_health <= 0:
		quit = true;
