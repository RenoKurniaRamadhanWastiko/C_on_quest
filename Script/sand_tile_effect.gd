extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_Area2D_body_enter( body ):
	print("Grass")
	if body.is_in_group("Player"):
		body.set_move_speed(1.6)
