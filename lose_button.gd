extends Button

func _on_danger_zone_game_lost():
	visible = true
	get_node("Timer").start()
	print("timer started")

func _on_pressed():
	get_tree().reload_current_scene()

func _on_timer_timeout():
	disabled = false
	print("abled!")
