extends Node2D

@export var Fruit: PackedScene

var rng = RandomNumberGenerator.new()
var is_lost = false
var is_ready = true

var current_fruit
var next_fruit

func _ready():
	current_fruit = spawn_fruit(0)
	next_fruit = get_node("Next/Fruit")
	next_fruit.start()
	next_fruit.gravity_scale = 0.0
	next_fruit.set_type(0)

func _input(event):
	if is_ready && not is_lost && event.is_action_pressed("click"):
		current_fruit.start()
		
		var t = Timer.new()
		t.set_wait_time(0.4)
		t.set_one_shot(true)
		self.add_child(t)
		
		is_ready = false
		
		t.start()
		await t.timeout
		t.queue_free()
		
		is_ready = true
		
		current_fruit = spawn_fruit(next_fruit.type)
		
		next_fruit.set_type(rng.randi_range(0, 4))

func spawn_fruit(type):
	var new_fruit = Fruit.instantiate()
	new_fruit.set_type(type)
	add_child(new_fruit)
	new_fruit.position = Vector2(550, 30)
	return new_fruit

func fuse_fruits(type, pos):
	var new_fruit = Fruit.instantiate()
	new_fruit.set_type(type)
	new_fruit.position = pos
	new_fruit.start()
	call_deferred("add_child", new_fruit)

func _on_danger_zone_game_lost():
	is_lost = true
