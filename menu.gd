extends Node2D

var  savepath := "user://savegame.save"

func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _ready() -> void:
	Score.load_score()
	$Camera2D/Label2.text = "highscore : " + str(Score.bscore)
