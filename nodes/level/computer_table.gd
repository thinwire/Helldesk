extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setState(state: int):
	$Monitor.get_surface_material(0).set_shader_param("state", state);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
