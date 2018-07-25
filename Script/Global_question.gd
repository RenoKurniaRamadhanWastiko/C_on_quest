extends Node
# Answer Part
var answer = ""
var question = ""
var choice_box = []

#Qestion Part
var question_list = []
var answer_list = []
var choice_list = []

func _ready():
	#Making the game basic question
	#This just for example
	question_list = [
		"The Enemy seems weak to spell that could make integer variable kaboom!",
		"Weakness identified, it must be the spell sign that end all spell line!",
		"Quick! the enemy seem weak to multiplication spell, we need to amplify this doom Spell with Sign!",
		"We already prepared the spell but somthing wrong!,it need to define the structur!",
		"The Enemy seems weak to data type spell, it must be the character spell!",
		"The Enemy seems weak to data type spell, it must be the integer spell!",
		"The Enemy seems weak to data type spell, it must be the float spell!",
		#8
		"We need combo spell that active while the enemy is idling!",
		"We need space allocation spell that could make us memorize the enemy attack and counter it!",
		"it seems the enemy reads our move well, we need our spell to act randomly",
	]
	answer_list = [
		"int kaboom",
		"Spell ;",
		"doom*doom",
		"typedef struct",
		"char",
		"int",
		"float",
		#8
		"while(enemy==idling)",
		"malloc()",
		"rand()",
	]
	choice_list  = [
	#No 1
		"String kaboom",
		"integer kaboom",
		"int kaboom",
		"INT KABOOM",
	#No 2
		"Spell =",
		"Spell ;",
		"Spell :",
		"Spell >",
	#No 3
		"doom*doom",
		"doomxdoom",
		"doom-doom",
		"doom+doom",
	#No 4
		"typedef struct",
		"define magic",
		"structur definition",
		"define struct",
	#No 5
		"float",
		"int",
		"string",
		"char",
	#No 6
		"float",
		"int",
		"string",
		"char",
	#No 7
		"float",
		"int",
		"string",
		"char",
	#No 8
		"while(enemy==idling)",
		"while(enemy=idling)",
		"while(idling)",
		"for(enemy==idling)",
	#No 9
		"malloc()",
		"allocate()",
		"define_space",
		"save()",
	#No 9
		"randy()",
		"random()",
		"rand()",
		"puzle()",
	]

func make_question():
	randomize()
	reset_choice()
	var Question_index = int(rand_range(0,10))
	question = question_list[Question_index]
	answer = answer_list[Question_index]
	var start = (Question_index)*4
	for i in range(0,4):
		choice_box.append(choice_list[start+i])

func reset_choice():
	choice_box = []

func get_answer():
	return answer 
func get_question():
	return question
func get_choice():
	return choice_box