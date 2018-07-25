extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var HP = 100
var charname = "R.I.C.O"
var strength = 10
var agility = 10
var intelligent = 10
var ori_strength = 10
var ori_agility = 10
var ori_intelligent = 10
var play_state = true
var active_spell =[]
var spell_index = 0
var effect_reset = false
var need_reset_spell
var percent_hp = 100.0
var shader = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	init_spell()
	pass

#Setter Part
#set playing state, the state will be false when player trigger battle scene
func set_play_state(new_state):
	#Variable need to be true or false
	play_state = new_state

#character default status
func set_new_Inteligent(intel):
	intelligent = intel

func set_new_Agility(agil):
	agility = agil

func set_new_strength(strh):
	strength = strh

func set_new_charname(name):
	charname = name

#Spell
func init_spell():
	for i in range(3):
		active_spell.append(4)

func reset_spell():
	for i in range(3):
		active_spell[i] = 4
	spell_index = 0

func set_new_active_spell(spell):
	if active_spell_checker(spell):
		if spell_index>2:
			spell_index = 0
			effect_reset = true
			need_reset_spell = active_spell[spell_index]
			#reset_spell_effect(active_spell[spell_index])
		active_spell[spell_index] = spell
		spell_index+=1
		

func active_spell_checker(spell):
	var x
	for z in range(3):
		if active_spell[z] == spell:
			active_spell[z] == 4
			for x in range(z,2):
				if not active_spell[x+1]==4:
					active_spell[x] = active_spell[x+1]
				else:
					active_spell[x] = 4
			active_spell_count()
			active_spell[2]=4
			return false
	return true

func active_spell_count():
	var count = 0
	for x in range(2):
		if active_spell[x]!= 4:
			count+=1
	print(count)
	spell_index = count
#Getter Part
	#set playing state, the state will be false when player trigger battle scene
func get_play_state():
	#Variable need to be true or false
	return play_state
	
#character default status
func get_new_Inteligent():
	return intelligent

func get_new_Agility():
	return agility

func get_new_strength():
	return strength

func get_new_charname():
	return charname 

func get_new_active_spell():
	return active_spell

#character Status Modifier
func status_mod_addition(var strh, var agil, var intl):
	strength += strh
	intelligent += intl
	agility += agil

#status Upgrader
func agility_upgrade():
	agility+=1
	ori_agility+=1
	Global_level.reduce_additional_stats()
	Global_level.start_player_body_maker()
func strenght_upgrade():
	strength+=1
	ori_strength+=1
	Global_level.reduce_additional_stats()
	Global_level.start_player_body_maker()
func intelligent_upgrade():
	intelligent+=1
	ori_intelligent+=1
	Global_level.reduce_additional_stats()
	Global_level.start_player_body_maker()

func reset_to_origin():
	agility = ori_agility
	strength = ori_strength
	intelligent = ori_intelligent


