extends Node2D

onready var TIE = get_node("TIE")
onready var p_dmg = get_node("Combat_info/Player_info/Damage_fill")
onready var p_spd = get_node("Combat_info/Player_info/Speed_fill")
onready var p_hlt = get_node("Combat_info/Player_info/Health_fill")

onready var e_dmg = get_node("Combat_info/Enemy_info/Damage_fill")
onready var e_spd = get_node("Combat_info/Enemy_info/Speed_fill")
onready var e_hlt = get_node("Combat_info/Enemy_info/Health_fill")

onready var ans1 = get_node("Answer_btn/Answer1")
onready var ans2 = get_node("Answer_btn/Answer2")
onready var ans3 = get_node("Answer_btn/Answer3")
onready var ans4 = get_node("Answer_btn/Answer4")
onready var ans_mast = get_node("Answer_btn")

onready var enemy_label_name = get_node("Enemy_info/name")
onready var con_btn = get_node("con_btn")
onready var end_timer = get_node("End_timer")
onready var enter_timer = get_node("Enter_timer")
onready var anim_combat = get_node("AnimationPlayer")
onready var En_sprite = get_node("Polygon2D/Enemy")
onready var go = get_node("Game_over")
onready var mxs = get_node("Game_over1")

var in_convers = false
var end_convers = false
var input_string = ""
var answ_string = ""

const BASE_EN_STATS = 30
const BASE_COM_SUCCES_HIT = 0.5
const BASE_SUPPORT_HIT = 0.25

var en_HP
var en_speed
var en_damage
var en_stat_mod = 1
var en_tot_stat = 0
var name = ""

#Q&A Mechanic
var choice = []
#-state
var end_init = false
var end_make = false
var end_phase = false
var end_en_phase = false
var end_dead_flage =false
var end_dead_flage_lost =false
var mand_stop = false
var state_con = true
var can_exit = false
var prep_exit = false
var re_combat = false
var attakced= false
var ready = false


func _ready():
	TIE.set_color(Color(0,0,0))
	set_process(true)
	TIE.connect("buff_end",self,"on_buff_end")
	con_btn.hide()
	ans_mast.hide()

func _process(delta):
	#true when the text reach bottom and user pressed enter button
	if TIE._max_lines_reached and Input.is_action_pressed("ui_accept") and in_convers:
		TIE.clear_text()
	#true when there are no more text buffer
	if end_convers and Input.is_action_pressed("ui_accept"):
		TIE.clear_text()

	if self.is_visible() and state_con:
		anim_combat.play("enter")
		enter_timer.start()
		init_convers()
		state_con = false
	elif not self.is_visible() and not state_con:
		TIE.reset()
		state_con = true
		con_btn.hide()
		name = ""
		ans_mast.hide()

func init_convers():
	#init enemy
	en_init()
	e_dmg.set_text(str(en_damage))
	e_spd.set_text(str(en_speed))
	e_hlt.set_text(str(en_HP))

	#init player
	p_dmg.set_text(str(Global_level.player_damage))
	p_spd.set_text(str(Global_level.player_speed))
	p_hlt.set_text(str(Global_level.percent_hp*Global_level.player_max_hp/100))

	#init coms
	name_gen()
	enemy_label_name.set_text(name)
	TIE.reset()
	input_string = name + ", is attacking, prepare the spell forge!"
	TIE.buff_text(input_string,0.01)
	TIE.set_state(TIE.STATE_OUTPUT)
	
func en_init():
	var hp
	var dmg
	var spd
	randomize()
	En_sprite.set_frame(int(rand_range(0,6)))
	en_stat_mod = Global_World.get_world()/10
	en_tot_stat =int(BASE_EN_STATS + 10 * en_stat_mod)
	randomize()
	hp = int(rand_range(3,en_tot_stat/2-1))+1
	dmg = int(rand_range(3,en_tot_stat-hp/3*4-1))+1
	spd = int(rand_range(3,en_tot_stat-hp-dmg-1))+1
	en_HP = hp
	en_speed = spd
	en_damage = dmg

func name_gen():
	randomize()
	var i = int(rand_range(1,6))
	if i == 1:
		name=name+ "Uraga "
	elif i == 2:
		name = name+"Decalpo "
	elif i == 3:
		name = name+"Mineva "
	elif i == 4:
		name = name+"Krumb "
	elif i == 5:
		name = name+"Draught "
	elif i == 5:
		name = name+"Cromwell "
	
	var y = int(rand_range(1,6))
	if y == 1:
		name = name+"The Code Dweller"
	if y == 2:
		name = name+"The Bug"
	if y == 3:
		name = name+"The Code Eater"
	if y == 4:
		name = name+"The Anti-program"
	if y == 5:
		name = name+"The Unhandled"
	print(name)
	return name

#connect from node TIE
func on_buff_end():
	if not end_init :
		make_question_local()
		end_init = true
	elif not end_make :
		print("a")
		make_stage()
		end_make = true
	elif not end_phase :
		print("b")
		attack_phase()
		end_phase = true
	elif not end_en_phase:
		print("c")
		en_attack_phase()
		end_en_phase = true
	elif end_dead_flage:
		end_point()
		end_dead_flage = false
	elif end_dead_flage_lost:
		lost_end_point()
	if not mand_stop and not prep_exit:
		con_btn.show()

func make_question_local():
	Global_question.make_question()
	choice = Global_question.get_choice()
	print(Global_question.get_question())
	input_string = Global_question.get_question() + ", now forge the spell!"
	for i in range(0,4):
		print(choice[i])
	print("end")
	end_make = false

func make_stage():
	mand_stop = true
	ans1.set_text(choice[0])
	ans2.set_text(choice[1])
	ans3.set_text(choice[2])
	ans4.set_text(choice[3])
	end_phase = false
	ans_mast.show()

func _on_con_btn_pressed():
	TIE.reset()
	TIE.buff_text(input_string,0.01)
	TIE.set_state(TIE.STATE_OUTPUT)
	con_btn.hide()
	if can_exit:
		end_timer.start()
		anim_combat.play("exit")
		prep_exit = true
	if attakced:
		anim_combat.play("attacked")
		attakced = false

func combat_phase():
	input_string = Global_state.charname+" using forge "+answ_string+"!"
	TIE.reset()
	TIE.buff_text(input_string,0.01)
	TIE.set_state(TIE.STATE_OUTPUT)
	con_btn.hide()

func attack_phase():
	randomize()
	var damage = 0
	var prob = rand_range((Global_level.player_speed-en_speed)/100+BASE_COM_SUCCES_HIT,1)
	if prob<0:
		prob+=BASE_SUPPORT_HIT
	
	randomize()
	if prob>0.5:
		anim_combat.play("attack")
		if answ_string == Global_question.get_answer():
			damage = int(rand_range(Global_level.player_damage/2,Global_level.player_damage))
		elif answ_string != Global_question.get_answer():
			damage = int(rand_range(Global_level.player_damage/4,Global_level.player_damage/2))
		if damage>=Global_level.player_damage/2:
			input_string = "its super effective, dealing "+str(damage)+" damage!"
		elif damage>=Global_level.player_damage/4:
			input_string = "its not very effective, dealing "+str(damage)+" damage!"
	else:
		input_string = name+", quikly move and succesfully evade!"
	en_HP -= damage
	e_hlt.set_text(str(en_HP))
	if en_HP<=0:
		end_dead_flage  = true
		end_en_phase = true
	mand_stop = false
	if en_HP>0:
		end_en_phase = false

func en_attack_phase():
	var damage = 0
	randomize()
	var prob = rand_range((en_speed-Global_level.player_speed)/100+BASE_COM_SUCCES_HIT,1)
	if prob<0:
		prob+=BASE_SUPPORT_HIT
	if en_HP>0:
		end_init = false
	randomize()
	if prob>0.5:
		attakced = true
		damage = int(rand_range(en_damage/3,en_damage))
		input_string = name+" attack!, dealing "+ str(damage)+" damage!."
	else:
		input_string = name+" attacking!,but "+Global_state.charname+" quickly move and succesfully evade!"
	Global_level.do_damage(damage)
	p_hlt.set_text(str(Global_level.percent_hp*Global_level.player_max_hp/100))
	if Global_level.player_hp<=0:
		end_init = true
		end_dead_flage_lost =true

func lost_end_point():
	input_string = Global_state.charname+" has defeated!, game over"
	Global_state.play_state = false
	mxs.set_text("max score: "+str(Global_score.get_score()))
	anim_combat.play("defeat")

func end_point():
	print("end")
	var got_exp =int(en_tot_stat)
	var got_score = en_tot_stat*5
	self.get_parent().got_score(got_score)
	self.get_parent().got_exp(got_exp)
	self.get_parent().on_winning()
	input_string = Global_state.charname+" has won!, earn "+str(got_exp)+" EXP and "+str(got_score)+" Score!"
	can_exit = true

func _on_Answer1_pressed():
	answ_string = ans1.get_text()
	ans_mast.hide()
	combat_phase()

func _on_Answer2_pressed():
	answ_string = ans2.get_text()
	ans_mast.hide()
	combat_phase()

func _on_Answer3_pressed():
	answ_string = ans3.get_text()
	ans_mast.hide()
	combat_phase()

func _on_Answer4_pressed():
	answ_string = ans4.get_text()
	ans_mast.hide()
	combat_phase()

func _on_End_timer_timeout():
	Global_state.play_state = true
	end_init = false
	end_make = false
	end_phase = false
	end_en_phase = false
	end_dead_flage =false
	end_dead_flage_lost =false
	mand_stop = false
	can_exit = false
	prep_exit = false
	ready = false
	end_timer.stop()
	self.hide()

func _on_Enter_timer_timeout():
	ready = true
	enter_timer.stop()

func _on_rply_pressed():
	Global_level.lvl = 1
	Global_World.world_level = 1
	Global_score.score = 0
	Global_level.player_hp = Global_level.BASE_HP
	Global_level.player_max_hp = Global_level.BASE_HP
	Global_level.percent_hp = 100.0
	Global_state.strength = 10
	Global_state.intelligent = 10
	Global_state.agility = 10
	get_tree().change_scene("res://Scene/World.tscn")
