extends Spatial

onready var animations: AnimationTree = find_node("cave_animation");
onready var club: Node = find_node("club");

func idle():
	club.visible = false;
	animations["parameters/transition/current"] = 0;

func angry():
	club.visible = false;
	animations["parameters/transition/current"] = 1;
	
func smash():
	club.visible = true;
	animations["parameters/transition/current"] = 2;
