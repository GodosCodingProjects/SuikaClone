extends Area2D

signal game_lost()

var overlapping_bodies = []

func _process(delta):
	if Input.is_action_pressed("end"):
		game_lost.emit()

func _physics_process(delta):
	for body in overlapping_bodies:
		if is_instance_valid(body) && not body.just_dropped && \
		body.linear_velocity.length_squared() < 0.00001:
			game_lost.emit()
			set_physics_process(false)

func _on_body_entered(body):
	if body.has_method("set_type"):
		overlapping_bodies.append(body)
		print("entered")

func _on_body_exited(body):
	for i in overlapping_bodies.size():
		if overlapping_bodies[i] == body:
			overlapping_bodies.remove_at(i)
			print("exited")
