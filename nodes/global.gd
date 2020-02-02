extends Node

#
# Player related stuff
#

const MAX_MONEY = 75000;

var player_health: int = MAX_MONEY;
var player: KinematicBody = null;

var session_time: float = 0.0;

var running: bool = false;

#
# Table related stuff
#

var tables: Array = [];
var activeTable: Node = null;

var servers: Array = [];
var activeServer: Node = null;

func reset():
	running = false;
	tables = [];
	activeTable = null;
	servers = [];
	activeServer = null;
	player_health = MAX_MONEY;
