extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var score = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func add_score(addition):
	score+=addition
func get_score():
	return score
	
