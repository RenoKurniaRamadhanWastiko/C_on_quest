extends StaticBody2D

onready var BS = get_node("../../BattleScene")
	
func Interact():
	Global_state.play_state = false
	BS.show()
	
