extends CanvasLayer
#Object picking up and status tracker
#this code is planned to be used in item and status monitor

var lap_indicator
var health_indicator
var item_indicator
var time_indicator
var pickup_indicator

func _ready():
	lap_indicator = get_node("LapCounter")
	health_indicator = get_node("HealthCounter")
	item_indicator = get_node("ItemCounter")
	time_indicator = get_node("TimeCounter")
	pickup_indicator = get_node("Pickup")


func update_health_indicator(counter):
	health_indicator.set_bbcode(str(counter) + " health")

func update_item_indicator(counter):
	item_indicator.set_bbcode(str(int(counter)) + " items")

func update_pickup_indicator(powerUp):
	pickup_indicator.set_bbcode(powerUp)

func update_time_indicator(time):
	time_indicator.set_bbcode(get_time_string(time))

#todo: Merge this with get_time_string in menu_level_end.gd
func get_time_string(time):
	var minutes = 0
	var seconds = 0
	var milliseconds = 0
	milliseconds = str(int(time * 100) % 100)
	time = int(time)
	var seconds = str(time % 60)
	time = time - (time % 60)
	minutes = str(time / 60)
	return minutes.pad_zeros(2) + ":" + seconds.pad_zeros(2) + ":" + milliseconds.pad_zeros(2)