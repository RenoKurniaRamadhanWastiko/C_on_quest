extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var target = get_node("../Player")
onready var bounds = get_node("../../Boundary")

var unbound = true
var right_bound = false
var left_bound = false
var top_bound = false
var bottom_bound = false

func _ready():
	OS.set_window_resizable(false)
#	set_pos(Vector2(target.get_pos().x,target.get_pos().y))
	
	set_limit(0, bounds.get_left())
	set_limit(1, bounds.get_top())
	set_limit(2, bounds.get_right())
	set_limit(3, bounds.get_bottom())
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	"""
func _fixed_process(delta):
#this part of code need upgrade!
	"""
	print("TOP_bound "+str(top_bound))
	print("Bottom_bound "+str(bottom_bound))
	print("LEFT_bound "+str(left_bound))
	print("RIGHT_bound "+str(right_bound))
	print("BOUNDING "+str(unbound))
	print("")
	"""
#	print(bounds.get_left())
#	print(get_zoom().x*OS.get_window_size().x/2)
#GUI and Character BOUNDING to LEVEL

#Bounding camera if the camera get to Right Limit
	if get_limit(2)-(get_global_pos().x+OS.get_window_size().x*get_zoom().x/2)<0:
		if not top_bound or not bottom_bound:
			set_pos(Vector2(get_pos().x,target.get_pos().y))
			unbound = false
			right_bound = true
	if target.get_global_pos().x < get_global_pos().x and right_bound:
		unbound = true
		right_bound = false

#Bounding camera if the camera get to Left Limit
	if get_limit(0)+(get_global_pos().x-OS.get_window_size().x*get_zoom().x/2)<0:
		if not top_bound or not bottom_bound:
			set_pos(Vector2(get_pos().x,target.get_pos().y))
			unbound = false
			left_bound = true
	if target.get_global_pos().x > get_global_pos().x and left_bound:
		unbound = true
		left_bound = false
#Bounding camera if the camera get to top Limit
	if get_limit(1)+(get_global_pos().y-OS.get_window_size().y*get_zoom().y/2)<0:
		if not left_bound and not right_bound:
			set_pos(Vector2(target.get_pos().x,get_pos().y))
			unbound = false
			top_bound = true
	if target.get_global_pos().y > get_global_pos().y and top_bound:
		unbound = true
		top_bound = false
#Bounding camera if the camera get to bottom Limit
	if get_limit(3)-(get_global_pos().y+OS.get_window_size().y*get_zoom().y/2)<0:
		if not left_bound and not right_bound:
			set_pos(Vector2(target.get_pos().x,get_pos().y))
			unbound = false
			bottom_bound = true
	if target.get_global_pos().y < get_global_pos().y and bottom_bound:
		unbound = true
		bottom_bound = false
#Release Any Camera Bounding
	if unbound:
		set_pos(Vector2(target.get_pos().x,target.get_pos().y))
	"""
	"""
#Experimental Bounding code, Any bug might be appeared
	print("Left "+str(get_limit(0)+(get_global_pos().x-OS.get_window_size().x*get_zoom().x/2)))
	print("top "+str(get_limit(1)+(get_global_pos().y-OS.get_window_size().y*get_zoom().y/2)))
	print("right "+str(get_limit(2)-(get_global_pos().x+OS.get_window_size().x*get_zoom().x/2)))
	print("bottom "+str(get_limit(3)-(get_global_pos().y+OS.get_window_size().y*get_zoom().y/2)))
	print("")
	var left_bound = get_limit(0)+(get_global_pos().x-OS.get_window_size().x*get_zoom().x/2)
	var top_bound = get_limit(1)+(get_global_pos().y-OS.get_window_size().y*get_zoom().y/2)
	var right_bound = get_limit(2)-(get_global_pos().x+OS.get_window_size().x*get_zoom().x/2)
	var bottom_bound = get_limit(3)-(get_global_pos().y+OS.get_window_size().y*get_zoom().y/2)
	
	if left_bound<0 or right_bound<0:
		set_pos(Vector2(get_pos().x,target.get_pos().y))
		in_bound = true
	if top_bound<0 or bottom_bound<0:
		set_pos(Vector2(target.get_pos().x,get_pos().y))
		in_bound = true
	elif not in_bound:
		set_pos(Vector2(target.get_pos().x,target.get_pos().y))
	"""
	"""
	"""