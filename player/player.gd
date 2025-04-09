extends CharacterBody2D

var score = 0.0

@export var godmode = false

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var health = 100.0
var hit_grace = false

func _physics_process(delta: float) -> void:
	score += 1*delta
	$Camera2D/ui/score.text = str(int(score))
	$Camera2D/ui/health.value = health
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or $RayCast2D.is_colliding()):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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
	get_tree().reload_current_scene()



func _on_gracetimer_timeout() -> void:
	hit_grace = false
