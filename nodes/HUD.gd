extends Node

var lastBroken: int = 0;

func _ready():
	lastBroken = 0;
	

func _process(delta):
	
	var broken: int = 0;
	for t in global.tables:
		if t.isBroken():
			broken += 1;
	
	if(broken != lastBroken):
		$brokenLabel.text = "Broken computers: " + str(broken);
		lastBroken = broken;
