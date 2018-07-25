extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var pos1 = get_node("../Enemy_position/Position1")
onready var pos2 = get_node("../Enemy_position/Position2")
onready var pos3 = get_node("../Enemy_position/Position3")
onready var pos4 = get_node("../Enemy_position/Position4")
onready var pos5 = get_node("../Enemy_position/Position5")
onready var pos6 = get_node("../Enemy_position/Position6")
onready var pos7 = get_node("../Enemy_position/Position7")
onready var pos8 = get_node("../Enemy_position/Position8")

func _ready():
	var Enemy = preload("res://Scene/Enemy_paretable.tscn").instance()
	Enemy.set_pos(pos1.get_global_pos())
	add_child(Enemy)
	var Enemy1 = preload("res://Scene/Enemy_paretable.tscn").instance()
	Enemy1.set_pos(pos2.get_global_pos())
	add_child(Enemy1)
	var Enemy2 = preload("res://Scene/Enemy_paretable.tscn").instance()
	Enemy2.set_pos(pos3.get_global_pos())
	add_child(Enemy2)
	var Enemy3 = preload("res://Scene/Enemy_paretable.tscn").instance()
	Enemy3.set_pos(pos4.get_global_pos())
	add_child(Enemy3)
	var Enemy4 = preload("res://Scene/Enemy_paretable.tscn").instance()
	Enemy4.set_pos(pos5.get_global_pos())
	add_child(Enemy4)
	var Enemy5 = preload("res://Scene/Enemy_paretable.tscn").instance()
	Enemy5.set_pos(pos6.get_global_pos())
	add_child(Enemy5)
	var Enemy6 = preload("res://Scene/Enemy_paretable.tscn").instance()
	Enemy6.set_pos(pos7.get_global_pos())
	add_child(Enemy6)
	var Enemy7 = preload("res://Scene/Enemy_paretable.tscn").instance()
	Enemy7.set_pos(pos8.get_global_pos())
	add_child(Enemy7)
