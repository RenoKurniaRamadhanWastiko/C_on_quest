extends Label

var current_stats = 0

func _ready():
	
	set_process(true)

func _process(delta):
	if current_stats != Global_level.additional_stats:
		current_stats = Global_level.additional_stats
		set_label()

func set_label():
	self.set_text(str(Global_level.additional_stats))