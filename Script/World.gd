extends Node2D

var world_level = 1

func _ready():
	pass

func advance():
	world_level+=1

func get_world():
	return world_level

