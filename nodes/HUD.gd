extends Node

var _lastBudget  = 0;
var _lastUsers   = 0;
var _lastServers = 0;

func _ready():
	_lastUsers   = 0;
	_lastServers = 0;
	_lastBudget  = 0;
	_updateLabels();
	
func _updateLabels():
	var users = 0;
	for t in global.tables:
		if t.isBroken():
			users += 1;
			
	var servers = 0;
	for s in global.servers:
		if s.isBroken():
			servers += 1;
	
	var budget = global.player_health;
	
	if _lastUsers != users:
		$userLabel.text = "User error reports: " + str(users);
		_lastUsers = users;
		
	if _lastServers != servers:
		$serverLabel.text = "Server fault codes: " + str(servers);
		_lastServers = servers;
		
	if _lastBudget != budget:
		$moneyLabel.text = "IT Dept. Budget: $" + str(budget);
		_lastBudget = budget;


func _process(delta):
	_updateLabels();
