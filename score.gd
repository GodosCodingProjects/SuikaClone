extends Label

var score = 0

func _ready():
	update_score()

func update_score():
	get_node("Number").text = str(score)

func add_score(delta_score):
	score += delta_score
	update_score()
