extends Control

var index = 0
var current_index = 3
var opaque=1


func _ready():
	set_process(true)

func _process(delta):
	#Brute Force Methode
	if Global_level.percent_hp/100==0:
		get_child(0).set_opacity(0)
		get_child(1).set_opacity(0)
		get_child(2).set_opacity(0)
		get_child(3).set_opacity(0)
	elif Global_level.percent_hp/100<=0.25:
		get_child(0).set_opacity(1)
		get_child(1).set_opacity(0)
		get_child(2).set_opacity(0)
		get_child(3).set_opacity(0)
	elif Global_level.percent_hp/100<=0.5:
		get_child(0).set_opacity(1)
		get_child(1).set_opacity(1)
		get_child(2).set_opacity(0)
		get_child(3).set_opacity(0)
	elif Global_level.percent_hp/100<=0.75:
		get_child(0).set_opacity(1)
		get_child(1).set_opacity(1)
		get_child(2).set_opacity(1)
		get_child(3).set_opacity(0)
	else:
		get_child(0).set_opacity(1)
		get_child(1).set_opacity(1)
		get_child(2).set_opacity(1)
		get_child(3).set_opacity(1)
		

