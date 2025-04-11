extends Node

var  savepath := "user://savegame.save"
var score = 0
var bscore = 0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().set_pause(!get_tree().is_paused())
		for i in get_tree().get_nodes_in_group("pause"):
			i.visible = get_tree().is_paused()

func load_score():
	if FileAccess.file_exists(savepath):
		var file = FileAccess.open(savepath,FileAccess.READ)
		bscore = file.get_var(bscore)
	else : print("nosave")

func save():
	if score > bscore:
		bscore = score
		var file = FileAccess.open(savepath, FileAccess.WRITE)
		file.store_var(bscore)
		print("saved")
