extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Button_pressed():
	get_node("UI/Option").show()

func _on_Button2_pressed():
	get_node("UI/Start").show()
