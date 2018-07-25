extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var current_score = Global_score.get_score()
var new_score
onready var Score_bar = get_node("Label")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	Score_bar.set_text(str(current_score))
	set_process(true)

func _process(delta):
	new_score = Global_score.get_score()
	if current_score != new_score:
		Score_bar.set_text(str(new_score))
		current_score = new_score