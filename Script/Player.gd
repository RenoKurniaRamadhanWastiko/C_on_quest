extends KinematicBody2D

#sprite animation
#List of animation available
#Walking: Right,Left,Up,Down
#Idle: Right,Left,Up,Down
#calling methode example : walkleft(for moving left), idleleft(for idling character when facing left)
onready var anime_player = get_node("Anime")

#make the animation to be called once per action
var playing_anim = ""

#Player Controll goal, simple movement up, down, left, right
#player movement can only accept one input at a time
#only up, only down, or only left
#vector movement define the global player movement
var movement = Vector2()
var face_dir = "down"
var player_idle = true
var target_body
var speed = 2
var water_walking = false
var on_terrain = "grass"

var init = true


var Interaction_toogle_pressed = false
onready var Collision_node = get_node("CollisionShape2D")
onready var boundary = get_node("../../Boundary")
onready var Player_name = get_node("Player_name")


func _ready():
	set_collision_mask(2)
	set_layer_mask(2)
	set_fixed_process(true)
	Player_name.set_text(Global_state.get_new_charname())
	
func _fixed_process(delta):
	var motion = Vector2()
	if Global_state.get_play_state():
		set_speed(on_terrain)
		if Input.is_action_pressed("control_up") and not get_global_pos().y<boundary.get_top()+16:
			motion+=Vector2(0,-speed)
			face_dir = "up"
			player_idle = false
		elif Input.is_action_pressed("control_down") and not get_global_pos().y>boundary.get_bottom()+8:
			motion+=Vector2(0,speed)
			face_dir = "down"
			player_idle = false
		elif Input.is_action_pressed("control_Left") and not get_global_pos().x<boundary.get_left()+16:
			motion+=Vector2(-speed,0)
			face_dir = "left"
			player_idle = false
		elif Input.is_action_pressed("control_Right") and not get_global_pos().x>boundary.get_right():
			motion+=Vector2(speed,0)
			face_dir = "right"
			player_idle = false
		else:
			motion = Vector2()
			player_idle = true
		movement = motion
		Animation(face_dir)
		move(movement)
	else: 
		player_idle = true
		Animation(face_dir)

#Interaction Handling, this is the controller for player Action beside movement
	if Input.is_action_pressed("Interact") and not Interaction_toogle_pressed:
		Interaction_toogle_pressed = true
		if target_body != null:
			target_body.Response()
	elif not Input.is_action_pressed("Interact"):
		Interaction_toogle_pressed = false

#Handling varioud animation method based on player direction, this code is to dirty
func Animation(dir):
#this part handling the moving animation, idle animation got handled separated
	if dir == "right" and not playing_anim == "walkright":
		anime_player.play("walkright")
		playing_anim = "walkright"
	elif dir  == "left" and not playing_anim == "walkleft":
		anime_player.play("walkleft")
		playing_anim = "walkleft"
	elif dir == "up" and not playing_anim == "walkup":
		anime_player.play("walkup")
		playing_anim = "walkup"
	elif dir =="down" and not playing_anim == "walkdown":
		anime_player.play("walkdown")
		playing_anim = "walkdown"
		
#this part Handling the idle animator
	elif dir == "up" and player_idle:
		anime_player.play("idleup")
		playing_anim = ""
	elif dir == "down" and player_idle:
		anime_player.play("idledown")
		playing_anim = ""
	elif dir == "left" and player_idle:
		anime_player.play("idleleft")
		playing_anim = ""
	elif dir == "right" and player_idle:
		anime_player.play("idleright")
		playing_anim = ""
		
#need Better Methode for character Interaction
#Signal Only call once, its when a body enter area
#Prototype Variable Interaction ID
func _on_Area2D_body_enter( body ):
	if body.is_in_group("Interaction"):
		body.Interact()
		target_body = body

func set_move_speed(new_speed):
	speed = new_speed
	
func _on_tile_effect_body_enter( body ):
	if body.is_in_group("Water_tile"):
		on_terrain = "water"
	elif body.is_in_group("Sand_tile"):
		on_terrain = "sand"
	elif body.is_in_group("Grass_tile"):
		on_terrain = "grass"

func togle_water_walk():
	if not water_walking:
		set_layer_mask(4)
		set_collision_mask(4)
		water_walking = true
	else:
		if not on_terrain == "water":
			set_layer_mask(2)
			set_collision_mask(2)
			water_walking = false
			
#Terrain Setter Getter
func set_speed(terrain):
	if terrain =="water":
		speed = 1
		anime_player.set_speed(0.5)
	elif terrain =="sand":
		speed = 1.5
		anime_player.set_speed(0.75)
	elif terrain == "grass":
		speed = 2
		anime_player.set_speed(1)
func get_terrain():
	return on_terrain

#Fog Clearance
func _on_Field_of_View_body_enter( body ):
	if body.is_in_group("Fog"):
		body.Fade()

func on_win():
	target_body.queue_free()
	print("wiiiin")
	pass
