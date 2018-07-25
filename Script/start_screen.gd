extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_Button_pressed():
	Global_state.charname = get_node("LineEdit").get_text()
	get_tree().change_scene("res://Scene/World.tscn")
