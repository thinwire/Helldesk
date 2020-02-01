extends Node

#
# Player related stuff
#

var player_health: int = 100;
var player: KinematicBody = null;


#
# Table related stuff
#

enum TableState {
	ACTIVE,
	BROKEN
}

var tableDeathTimeMin = 5;		# min time to wait before breaking computer
var tableDeathTimeMax = 15;		# max time to wait before breaking computer

var tables = [];
var activeTable: Node = null;


