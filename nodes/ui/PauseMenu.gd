extends Node2D

var fadeout = 0.0;
var quit = false;
var wasVisible = false;

func _ready():
	fadeout = 0.0;
	quit = false;
	wasVisible = false;
	visible = false;
	
func _process(delta):
	if quit:
		# Has to be done here because of init order and we have no time left to
		# do any kind of architecturing
		var crtshader = get_parent().get_parent().find_node("crtshader");

		if fadeout < 1.0:
			fadeout += delta * 0.5;
			fadeout = min(fadeout, 1.0);
			crtshader.get_material().set_shader_param("fade", fadeout);
		else:
			get_tree().quit();
			
	if wasVisible && Input.is_action_just_pressed("ui_cancel"):
		deactivate();
		
	wasVisible = self.visible;

func activate():
	get_tree().paused = true;
	self.visible = true;
	
func deactivate():
	self.visible = false;
	get_tree().paused = false;

func _on_resumeButton_pressed():
	deactivate();

func _on_quitButton_pressed():
	quit = true;
