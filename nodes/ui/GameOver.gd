extends Node2D

var fadein = 1.0;
var fadeout = 0.0;
var quit = false;
var retry = false;

func _ready():
	fadein = 1.0;
	fadeout = 0.0;
	quit = false;
	retry = false;
	$budgetLabel.text = "Your budget survived for " + str(int(global.session_time)) + " seconds";
	
func _process(delta):
	if fadein > 0.0:
		fadein -= delta * 0.5;
		fadein = max(fadein, 0.0);
		$postprocessLayer/crtshader.get_material().set_shader_param("fade", fadein);
	
	if quit:
		if fadeout < 1.0:
			fadeout += delta * 0.5;
			fadeout = min(fadeout, 1.0);
			$postprocessLayer/crtshader.get_material().set_shader_param("fade", fadeout);
		else:
			if retry:
				get_tree().change_scene("res://nodes/gameworld.tscn");
			else:
				get_tree().quit();

func _on_TextureButton_pressed():
	quit = true;
	retry = false;

func _on_retryButton_pressed():
	quit = true;
	retry = true;
