extends Node

#
# Game world control stuff
#

enum QuitMode {
	EXIT_GAME,
	GAME_OVER
}

var fadein: float  = 1.0;
var fadeout: float = 0.0;
var quit: bool     = false;
var quitMode       = 0;

func _ready():
	global.player = $player
	global.session_time = 0.0;
	fadein  = 1.0;
	fadeout = 0.0;
	quit    = false;
	
func _handleQuit():
	global.reset();
	quit = false;
	
	if quitMode == QuitMode.EXIT_GAME:
		get_tree().quit(0);
	elif quitMode == QuitMode.GAME_OVER:
		get_tree().change_scene("res://nodes/ui/GameOver.tscn");

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
			_handleQuit();
	
	# Pitch music up as money drains
	$music.pitch_scale = 1.0 + (1.0 - (float(global.player_health) / float(global.MAX_MONEY)));
	
	if Input.is_action_just_pressed("ui_cancel") && fadein == 0.0:
		$menuLayer/PauseMenu.activate();

	if global.player_health <= 0:
		quitMode = QuitMode.GAME_OVER;
		quit = true;
		
	global.session_time += delta;
