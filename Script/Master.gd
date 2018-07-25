extends Node2D

var width = 48
var height = 24
var map_grid

var world_generated = false
#Making preloaded Script
var preScript = preload("res://Script/softnoise.gd")
#variable to instance the script
var softNoise
#debugin variable
var debug_exp = false
var debug_dmg = false

#variable for togle
var on_water_walk = false
var on_primal_rage = false
var on_enigma = false
var on_wind_walk = false


#misc const
const MISC1 = 12
const MISC2 = 6
const MISC3 = 7
const EN_COUNT = 4

var en_def = 0

onready var Master_terrain = get_node("Terrain")
onready var Battle_sc = get_node("BattleScene")
onready var Terrain_lvl1 = get_node("Terrain/Water")
onready var Terrain_lvl2 = get_node("Terrain/Sand")
onready var Terrain_lvl3 = get_node("Terrain/Grass")
onready var Terrain_deco = get_node("Terrain_deco/Flower")
onready var Terrain_misc = get_node("Terrain_deco/misc")
onready var Scene_timer = get_node("Timer")
onready var Curtain = get_node("Flash_curtain/AnimationPlayer")
onready var Character = get_node("Character_UI")
onready var target_camera = get_node("Character_UI/Camera")
onready var Player_char = get_node("Character_UI/Player")
onready var boundary = get_node("Boundary")
onready var Player_exp_bar = get_node("Character_UI/Camera/GUI/EXP_bar")
onready var Status_bar = get_node("Character_UI/Camera/GUI/Status_bar")
onready var shader_frame = get_node("Shader")


func _ready():
#Preparing Method for multiple Terrain Control!
	if Global_state.shader:
		shader_frame.show()
	Global_state.set_play_state(true)
	Global_state.reset_spell()
	world_generate()
	set_process(true)

func _process(delta):
	if en_def==EN_COUNT:
		en_def = 0
		Global_state.reset_to_origin()
		Global_level.full_heal()
		Curtain.play("fade_in")
		Global_state.set_play_state(false)
		Scene_timer.start()
	if Input.is_action_pressed("do_damage") and not debug_dmg:
		Global_level.do_damage(1)
		debug_dmg = true
	elif not Input.is_action_pressed("do_damage") and debug_dmg:
		debug_dmg = false
	
	if Input.is_action_pressed("Generate"):
		Global_state.reset_to_origin()
		Global_level.full_heal()
		Curtain.play("fade_in")
		Global_state.set_play_state(false)
		Scene_timer.start()
	if Input.is_action_pressed("Interact")and not debug_exp:
		Player_exp_bar.got_exp(1000)
		Global_score.add_score(1000)
		debug_exp = true
	elif not Input.is_action_pressed("Interact") and debug_exp:
		debug_exp = false
	
	if Input.is_action_pressed("Quit"):
		Battle_sc.hide()
		Global_state.set_play_state(true)

#create matrix based on map size in widht and height
func create_matrix(w,h):
#initialize matrix with a null array
	var matrix = []
	var scale = .007	
	for x in range(w):
#appending the array with null value cause the matrix to be divided in 2D
#first matrix form matrix = {{}}
		matrix.append([])
		for y in range(h):
#append the value to the matrix
#from the matrix {[]} -> {[value]}
#the initialized value was matrix with index x but sit will have 2 diemsion index
			matrix[x].append(sqrt(sqrt(softNoise.openSimplex2D(x * scale, y * scale) + 1) / 2.0 * 255.0)-10.5)
	return matrix
	"""
#making the map with tilemap, still in development using only 2 sample tile, land and water
func map_generate(width,height,grid):
	var grass = 2.01 #1,2
	var sand = 1.8 #4
	var water = 1.5#3
	for x in range(width):
		for y in range(height):
			randomize()
			if grid[x][y]>grass:
				Terrain_lvl3.set_cellv(Vector2(x,y),int(rand_range(1,3)),false,false,false)
				if int(rand_range(1,3))==1:
					Terrain_deco.set_cellv(Vector2(x,y),int(rand_range(0,2)),false,false,false)
			elif grid[x][y]>sand:
				Terrain_lvl2.set_cellv(Vector2(x,y),4,false,false,false)
			elif grid[x][y]>water:
				Terrain_lvl1.set_cellv(Vector2(x,y),3,false,false,false)
			else:
				Terrain_lvl1.set_cellv(Vector2(x,y),3,false,false,false)
	"""
#tiling control start from here
#			if grid[x][y]<=water:
#				set_cellv(Vector2(x,y),3,false,false,false)
#			elif grid[x][y]<=sand and grid[x][y]>water:
#				set_cellv(Vector2(x,y),4,false,false,false)
#			elif grid[x][y]<=grass and grid[x][y]>sand:
#			else:
#				randomize()
#				set_cellv(Vector2(x,y),rand_range(1,2),false,false,false)

func map_generate_alter(width,height,grid):
	var grass = 0.4 #1,2
	var sand = 0.1 #4
	var water = -0.3#3
	var count_misc_1 = 0
	var count_misc_2 = 0
	var count_misc_3 = 0
	for x in range(width):
		for y in range(height):
			randomize()
			if grid[x][y]>grass:
				Terrain_lvl3.set_cellv(Vector2(x,y),int(rand_range(1,3)),false,false,false)
				if int(rand_range(1,3))==1:
					Terrain_deco.set_cellv(Vector2(x,y),int(rand_range(0,2)),false,false,false)
				if int(rand_range(1,20))==7 and not count_misc_1==MISC1:
					Terrain_misc.set_cellv(Vector2(x,y),int(rand_range(1,3)),false,false,false)
					count_misc_1+=1
			elif grid[x][y]>sand:
				Terrain_lvl2.set_cellv(Vector2(x,y),4,false,false,false)
				if int(rand_range(1,41))==21 and not count_misc_2==MISC2:
					Terrain_misc.set_cellv(Vector2(x,y),3,false,false,false)
					count_misc_2+=1
					
			elif grid[x][y]>water:
				Terrain_lvl1.set_cellv(Vector2(x,y),3,false,false,false)
			else:
				Terrain_lvl1.set_cellv(Vector2(x,y),5,false,false,false)

func world_generate():
	randomize()
	Curtain.play("fade_out")
	softNoise = preScript.SoftNoise.new(rand_range(150497,260197))
	map_grid = create_matrix(width,height)
	map_generate_alter(width,height,map_grid)
	Player_char.set_pos(Vector2(target_camera.get_pos().x,target_camera.get_pos().y))


func get_widht():
	return width
func get_height():
	return height
func _on_Timer_timeout():
	Global_World.advance()
	get_tree().change_scene("res://Scene/World.tscn")

#Button for Spell and ability
#Water_walk, Need FIX!!
#Water_walk, fixed for now
func _on_Button_pressed():
		if Player_char.init or not Player_char.on_terrain=="water":
			Player_char.init = false
			Player_char.togle_water_walk()
			Global_state.set_new_active_spell(0)
			if Global_state.effect_reset:
				reset_spell_effect(Global_state.need_reset_spell)
				Global_state.effect_reset = false
			Status_bar.update_spell_status()
			if not on_water_walk:
				Global_state.status_mod_addition(-2,-1,-1)
				on_water_walk = true
			elif on_water_walk:
				Global_state.status_mod_addition(2,1,1)
				on_water_walk = false

func _on_btn_wtr_PR_pressed():
	Global_state.set_new_active_spell(1)
	if Global_state.effect_reset:
		reset_spell_effect(Global_state.need_reset_spell)
		Global_state.effect_reset = false
	Status_bar.update_spell_status()
	if not on_primal_rage:
		Global_state.status_mod_addition(4,2,-5)
		on_primal_rage = true
	elif on_primal_rage:
		Global_state.status_mod_addition(-4,-2,5)
		on_primal_rage = false

func _on_btn_wtr_Enigma_pressed():
	Global_state.set_new_active_spell(2)
	if Global_state.effect_reset:
		reset_spell_effect(Global_state.need_reset_spell)
		Global_state.effect_reset = false
	Status_bar.update_spell_status()
	if not on_enigma:
		Global_state.status_mod_addition(-4,1,5)
		on_enigma = true
	elif on_enigma:
		Global_state.status_mod_addition(4,-1,-5)
		on_enigma = false

func _on_btn_wtr_WW_pressed():
	Global_state.set_new_active_spell(3)
	if Global_state.effect_reset:
		reset_spell_effect(Global_state.need_reset_spell)
		Global_state.effect_reset = false
	Status_bar.update_spell_status()
	if not on_wind_walk:
		Global_state.status_mod_addition(-4,6,-1)
		on_wind_walk = true
	elif on_wind_walk:
		Global_state.status_mod_addition(4,-6,1)
		on_wind_walk =  false

#UI controller
func _on_Char_info_pressed():
	if not get_node("Character_info").is_visible():
		get_node("Character_info").show()
		Global_state.set_play_state(false)
	else:
		get_node("Character_info").hide()
		Global_state.set_play_state(true)

func reset_spell_effect(index):
	if index== 0:
		status_mod_addition(2,1,1)
		on_water_walk = false
	elif index == 1 :
		status_mod_addition(-4,-2,5)
		on_primal_rage = false
	elif index == 2:
		status_mod_addition(4,-1,-5)
		on_enigma = false
	elif index == 3: 
		status_mod_addition(4,-6,1)
		on_wind_walk =false

func got_exp(experience):
	Player_exp_bar.got_exp(experience)

func got_score(score):
	Global_score.add_score(score)

func on_winning():
	en_def+=1
	Player_char.on_win()