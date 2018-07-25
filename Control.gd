extends Control

#init variable

onready var fog_of_war = get_node("TileMap")
var widht = 60
var height = 60


func _ready():
	for x in range(widht):
		for y in range (height):
			fog_of_war.set_cellv(Vector2(x,y),4,false,false,false)
			
	