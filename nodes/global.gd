extends Node

#
# Player related stuff
#

var player_health: int = 100;
var player: KinematicBody = null;

#
# Table related stuff
#

var tables = [];
var activeTable: Node = null;

var servers = [];
var activeServe: Node = null;
