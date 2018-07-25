extends StaticBody2D
#Experimental script used for testing player intercation with game object
onready var battle = get_node("../BattleScene")

func _ready():
	pass
func Interact():
	print("LOL")
	battle.show()
	Global_state.set_play_state(false)
func Response():
	print("LULU")
