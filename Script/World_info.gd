extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var current_world = Global_World.get_world()
var new_world
onready var canvas_info = get_node("Canvas_world")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	canvas_info.set_text(str(Global_World.get_world()))
	print(current_world)
	set_process(true)

func _process(delta):
	new_world = Global_World.get_world()
	if current_world!=new_world:
		canvas_info.set_text(str(Global_World.get_world()))
		new_world = current_world
		
