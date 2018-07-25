extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var Terrain = get_node("../Terrain")
onready var world = get_node("../../World")

func _ready():
	set_scale(Vector2(world.get_widht()/4,world.get_height()/4))
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func get_left():
	return get_pos().x - get_scale().x * 32
func get_right():
	return get_pos().x + get_scale().x *32
func get_top():
	return get_pos().y - get_scale().y * 32
func get_bottom():
	return get_pos().y + get_scale().y * 32
