extends Node2D

var fog = load("res://Fog of War.tscn")
onready var player = get_node("../Character_UI/Player")
var fogging = []

func _ready():
	for x in range(48):
		fogging.append([])
		for y in range(24):
			var cell = fog.instance()
			fogging[x].append(cell)
			self.add_child(cell)
			fogging[x][y].set_pos(Vector2(x*16+1,y*16+2))