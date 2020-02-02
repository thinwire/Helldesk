extends Node

#
# Player related stuff
#

var player_health: int = 50000;
var player: KinematicBody = null;

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
	player_health = 50000;
