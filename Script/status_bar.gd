extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var spell1 = get_node("spell2")
onready var spell2 = get_node("spell3")
onready var spell3 = get_node("spell4")
var active_spell = [3]

func _ready():
	spell1.set_frame(4)
	spell2.set_frame(4)
	spell3.set_frame(4)
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func update_spell_status():
	active_spell = Global_state.get_new_active_spell()
	spell1.set_frame(active_spell[0])
	spell2.set_frame(active_spell[1])
	spell3.set_frame(active_spell[2])
