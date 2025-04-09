extends Node2D

@onready var block = preload("res://obstacle/obstacle.tscn")
@onready var boss2 = preload("res://ennemy/boss2.tscn")
@onready var boss3 = preload("res://ennemy/boss3.tscn")
@onready var bosstimer2 = $boss_timer2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func spawn_block() :
	var block_inst : Area2D = block.instantiate() 
	add_child(block_inst)
	block_inst.global_position = $spawner.global_position

func _on_timer_timeout() -> void:
	spawn_block()
	$Timer.wait_time = randf_range(1.0,3.0)

func _on_boss_timer_timeout() -> void:
	var boss : Node2D = boss2.instantiate() 
	$Path2D/PathFollow2D.add_child(boss)
	boss.global_position = $Path2D/PathFollow2D.global_position
	$player.heal(25)

func _on_ennemy_boss_dead() -> void:
	$boss_timer.start()


func _on_boss_timer_2_timeout() -> void:
	var boss : Node2D = boss3.instantiate() 
	$Path2D/PathFollow2D.add_child(boss)
	boss.global_position = $Path2D/PathFollow2D.global_position
	$player.heal(50)
