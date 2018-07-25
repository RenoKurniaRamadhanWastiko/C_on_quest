extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var camera_pos = get_node("../../Camera")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)

func _process(delta):
	set_pos(Vector2(camera_pos.get_pos().x,camera_pos.get_pos().y))
