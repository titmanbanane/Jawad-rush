extends Area2D
var swerving = false
const speed = 6.0
var time = 0
var amplitude = 50
var base_y

func _ready() -> void:
	top_level = true

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("killzone") :
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") :
		body.hit(25)
		queue_free()

func _physics_process(delta: float) -> void:
	global_position.x -= speed
	if swerving :
		global_position.y = (cos(time) * amplitude) + base_y - amplitude
		time += delta * 7
