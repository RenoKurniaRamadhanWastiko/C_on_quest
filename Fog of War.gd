extends StaticBody2D


onready var anime = get_node("../Anime")

func Fade():
	anime.play("fade")
	