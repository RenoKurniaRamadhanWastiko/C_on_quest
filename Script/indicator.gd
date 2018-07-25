extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var hidden = false

func _ready():
	self.hide()
	set_process(true)

func _process(delta):
	if Global_level.additional_stats ==0:
		if not hidden:
			hidden = true
			self.hide()
	elif Global_level.additional_stats>0:
		if hidden:
			hidden = false
			self.show()
			
