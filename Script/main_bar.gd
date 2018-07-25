extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var LVL = get_node("LVL")
onready var exp_bar = get_node("../EXP_bar")
onready var cur_hp = get_node("Current_hp")
onready var m_hp = get_node("Max_hp")

var current_lvl = Global_level.get_global_level()
var new_level
var current_hp
var max_hp
var percent_hp = 0.0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	current_hp = Global_level.player_hp
	max_hp = Global_level.player_max_hp
	percent_hp = Global_level.percent_hp
	cur_hp.set_text(str(current_hp))
	m_hp.set_text("/ "+str(max_hp))
	LVL.set_text(str(current_lvl))
	set_process(true)

func _process(delta):
	#set new HP and new Max HP
	if percent_hp!=Global_level.percent_hp:
		percent_hp = Global_level.percent_hp
	current_hp = int(Global_level.player_max_hp*percent_hp/100)
	max_hp = int(Global_level.player_max_hp)
	cur_hp.set_text(str(current_hp))
	m_hp.set_text("/ "+str(max_hp))
	
	#level hadnler
	new_level = Global_level.get_global_level()
	if new_level!=current_lvl:
		LVL.set_text(str(Global_level.get_global_level()))
		current_lvl = new_level
	
	
	Global_level.player_speed = Global_state.agility*Global_level.BASE_SPEED/10.0
	Global_level.player_damage = Global_state.intelligent*Global_level.BASE_DAMAGE/10.0
	Global_level.player_max_hp = Global_state.strength*Global_level.BASE_HP/10.0
