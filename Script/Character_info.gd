extends Control

#Get Node
onready var char_name = get_node("Name_info/Label_char_inf")
onready var strg = get_node("Value_info/Label_str")
onready var agil = get_node("Value_info/Label_agi")
onready var intel = get_node("Value_info/Label_intel")
onready var point = get_node("Value_info/Label_point")


func _ready():
	char_name.set_text(Global_state.charname)
	set_process(true)

func _process(delta):
	#if Global_level.additional_stats == 0:
	#	get_node("Button/TextureButton2").set_disabled(true)
	#	get_node("Button/TextureButton1").set_disabled(true)
	#	get_node("Button/TextureButton").set_disabled(true)
	#elif Global_level.additional_stats >0:
	#	get_node("Button/TextureButton2").set_disabled(false)
	#	get_node("Button/TextureButton1").set_disabled(false)
	#	get_node("Button/TextureButton").set_disabled(false)
	strg.set_text(str(Global_state.strength))
	agil.set_text(str(Global_state.agility))
	intel.set_text(str(Global_state.intelligent))
	point.set_text(str(Global_level.additional_stats))

#str
func _on_TextureButton_pressed():
	if not Global_level.additional_stats==0:
		Global_state.strenght_upgrade()

#agi
func _on_TextureButton1_pressed():
	if not Global_level.additional_stats==0:
		Global_state.agility_upgrade()

#intel
func _on_TextureButton2_pressed():
	if not Global_level.additional_stats==0:
		Global_state.intelligent_upgrade()

func _on_Exit_pressed():
	self.hide()
	Global_state.set_play_state(true)
	
