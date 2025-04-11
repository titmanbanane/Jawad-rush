extends CharacterBody2D

var score = 0.0

@export var godmode = false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var health = 100.0
var hit_grace = false

func _physics_process(delta: float) -> void:
	score += 1*delta
	
	$Camera2D.position.y = lerp($Camera2D.position.y, position.y - 25, delta*10)
	$Camera2D/ui/score.text = str(int(score))
	$Camera2D/ui/health.value = health
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or $RayCast2D.is_colliding()):
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_pressed("ui_down"):
		if $RayCast2D.is_colliding():
			$CollisionShape2D.scale.y = 1
		else:
			velocity.y = -JUMP_VELOCITY
	else:
		$CollisionShape2D.scale.y = 2
	move_and_slide()

func hit(amount: float) :
	if !hit_grace and !godmode:
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.play("hit")
		velocity.y = JUMP_VELOCITY
		health -= amount
		if health <= 0 :
			die()
	$gracetimer.start()
	hit_grace = true

func heal(value):
	var t = get_tree().create_tween()
	t.tween_property(self, "health", health+value, 1)

func die():
	print(score)
	Score.score = int(score)
	Score.save()
	get_tree().change_scene_to_file("res://menu.tscn")



func _on_gracetimer_timeout() -> void:
	hit_grace = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hit" :
		$AnimationPlayer.play("run")
