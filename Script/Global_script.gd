extends Node

#This Global Node Contain Player Vital Data

const BASE_HP = 15
const BASE_DAMAGE = 15
const BASE_SPEED = 15

var lvl = 1
var total_exp = 100.0
var current_exp = 0.0
var world = 1

var percent_hp = 100.0
var max_hp_temp = 0.0
var cur_hp_temp = 0.0

var additional_stats = 0

#player Body
var player_hp=0.0
var player_damage=0
var player_speed=0
var player_max_hp = 0.0

func _ready():
	start_player_body_maker()
	player_hp = player_max_hp

func get_global_level():
	return lvl
func get_global_total_exp():
	return total_exp
func get_global_current_exp():
	return current_exp

func lvl_up():
	lvl +=1
	additional_stats +=1
	full_heal()

func add_exp(experience):
	current_exp+=experience

func exp_pool_increasse():
	total_exp+=current_exp
	#current_exp = 0

func reduce_additional_stats():
	additional_stats-=1
	
func do_damage(var dmg):
	player_hp-=dmg
	cur_hp_temp = float(player_hp)
	max_hp_temp = float(player_max_hp)
	percent_hp = cur_hp_temp/max_hp_temp*100

func do_heal(var heal):
	player_hp+=heal

func full_heal():
	player_hp = player_max_hp
	cur_hp_temp = float(player_hp)
	max_hp_temp = float(player_max_hp)
	percent_hp = cur_hp_temp/max_hp_temp*100


func start_player_body_maker():
	player_speed = Global_state.agility*BASE_SPEED/10.0
	player_damage = Global_state.intelligent*BASE_DAMAGE/10.0
	player_max_hp = Global_state.strength*BASE_HP/10.0
 


