extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var a = get_node("Label_fill")
onready var b = get_node("Label1_fill")
onready var c = get_node("Label2_fill")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)

func _process(delta):
	a.set_text(str(Global_state.agility))
	b.set_text(str(Global_state.strength))
	c.set_text(str(Global_state.intelligent))
