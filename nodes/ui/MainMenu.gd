extends Node2D

var time = 0;
var fadeout = 0.0;
var quit = false;


func _ready():
	fadeout = 0.0;
	quit = false;

func _process(delta):
	time += delta;
	$studiologo.rotation = sin(time * 0.31) * 0.029;
	$studiologo.scale.x = 1.0 + sin(time * 1.12) * 0.02;
	$studiologo.scale.y = 1.0 + sin(time * 1.12) * 0.02;

	if quit:
		if fadeout < 1.0:
			fadeout += delta * 0.5;
			fadeout = min(fadeout, 1.0);
			$postprocessLayer/crtshader.get_material().set_shader_param("fade", fadeout);
		else:
			get_tree().change_scene("res://nodes/gameworld.tscn");

func _on_startButton_pressed():
	quit = true;
