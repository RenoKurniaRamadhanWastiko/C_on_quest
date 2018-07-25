extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var region = Rect2()
var temp_texture = self.get_texture()
var widht = 54.5
var height = 14.5
var rect_x = 6.583
var rect_y = 291.8640
var progress = 0.0
var total_exp = Global_level.get_global_total_exp()
var current_exp = Global_level.get_global_current_exp()
var lvl = Global_level.get_global_level()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	exp_init()

func exp_init():
	progress = current_exp/total_exp
	if current_exp >= total_exp:
		total_exp+=current_exp
		current_exp = 0
		Global_level.exp_pool_increasse()
		Global_level.lvl_up()
		lvl+=1
		progress = 0
	region = Rect2(rect_x,rect_y,widht*progress,height)
	self.set_region_rect(region)
	
func _process(delta):
	if current_exp!= Global_level.current_exp:
		exp_init()

func got_exp(experience):
	current_exp +=experience
	Global_level.add_exp(experience)
	exp_init()