extends Area2D

const speed = 6.0

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("killzone") :
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") :
		body.hit(25)

func _physics_process(delta: float) -> void:
	global_position.x -= speed
