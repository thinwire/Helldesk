extends Spatial

onready var animations: AnimationTree = find_node("cave_animation");

func idle():
	animations["parameters/transition/current"] = 0;

func angry():
	animations["parameters/transition/current"] = 1;
	
func smash():
	animations["parameters/transition/current"] = 2;
