extends Node2D

@export var curvepoint : PathFollow2D
@onready var bullet = preload("res://bullet/bullet.tscn")

var curpoint = 1
var speed = 3

signal boss_dead


# BOss3 Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RayCast2D.top_level = true	
	curvepoint = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	$Php.global_position = global_position
	$RayCast2D.global_position = Vector2(global_position.x + 20,global_position.y)
	curvepoint.progress += speed

func spawn_block() :
	var bullet_inst : Area2D = bullet.instantiate() 
	add_child(bullet_inst)
	bullet_inst.global_position = global_position
	bullet_inst.base_y = global_position.y
	bullet_inst.swerving = true


func _on_timer_timeout() -> void:
	if !$RayCast2D.is_colliding():
		spawn_block()
	$Timer.wait_time = randf_range(0.1,1.0)

func _on_death_timeout() -> void:
	emit_signal("boss_dead")
	queue_free()
