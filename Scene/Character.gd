extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Interaction_area_body_enter( body ):
	if Input.is_action_pressed("Interact") and body.is_in_group("Interaction"):
		body.Interact()
