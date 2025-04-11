extends Node2D

@onready var block = preload("res://obstacle/obstacle.tscn")
@onready var boss2 = preload("res://ennemy/boss2.tscn")
@onready var boss3 = preload("res://ennemy/boss3.tscn")
@onready var boss4 = preload("res://ennemy/boss4.tscn")
var bossnb = 0
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
	match bossnb:
		1:
			var boss : Node2D = boss2.instantiate() 
			$Path2D/PathFollow2D.add_child(boss)
			boss.global_position = $Path2D/PathFollow2D.global_position
			$player.heal(25)
			boss.boss_dead.connect(_on_ennemy_boss_dead)
		2:
			var boss : Node2D = boss3.instantiate() 
			$Path2D/PathFollow2D.add_child(boss)
			boss.global_position = $Path2D/PathFollow2D.global_position
			$player.heal(50)
			boss.boss_dead.connect(_on_ennemy_boss_dead)
		3:
			var boss : Node2D = boss4.instantiate() 
			$Path2D/PathFollow2D.add_child(boss)
			boss.global_position = $Path2D/PathFollow2D.global_position
			$player.heal(75)
			bossnb = 0
			boss.boss_dead.connect(_on_ennemy_boss_dead)

func _on_ennemy_boss_dead() -> void:
	bossnb += 1
	$boss_timer.start()
