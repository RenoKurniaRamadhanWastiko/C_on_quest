extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var cb = get_node("CheckBox")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Button_pressed():
	self.hide()


func _on_CheckBox_pressed():
	if cb.is_pressed():
		Global_state.shader = true
		get_node("../shader").show()
	else:
		Global_state.shader = false
		get_node("../shader").hide()
