extends Node

var new_break = preload("res://Scenes/Break.tscn")
export var score = 0
export var lives = 3
export var combo = 0

var comboEffects = {
	0:[Color(0,0,0),1,Color(1,1,1)],
	5:[Color(.2,0,.25),1.5,Color(1,1,1)],
	10:[Color(.5,.25,.5),2,Color(.8,.8,.8)],
	15:[Color(.75,.5,.75),2.5,Color(.5,.5,.5)],
	20:[Color(1,.75,1),3,Color(.25,.25,.25)],
	25:[Color(1,1,1),3.5,Color(0,0,0)]
}

var whiteList = [
	find_node('Score'),
	find_node('Combo'),
	find_node('Lives'),
	find_node('Border'),
	find_node('Paddle'),
	find_node('Ball'),
	find_node('Stars')
]

var blackList = [
	find_node('Background')
]

func increase_score(s):
	score += int(s)
	find_node("Score").update_score()
	
func decrease_lives():
	lives -= 1
	find_node("Lives").update_lives()
	if lives <= 0:
		pass
		
func spawn_break(pos,col):
	var brk = new_break.instance()
	brk.position = pos
	brk.modulate = col
	brk.emitting = true
	add_child(brk)
	
func update_combo(n):
	if n == -1:
		combo = 0
	else:
		combo += n
	find_node("Combo").update_combo()
	var level = 0
	for i in comboEffects:
		if combo > i:
			level = i
	var effects = comboEffects[level]
	for i in whiteList:
		i.set_modulate(effects[2])
	for i in blackList:
		i.set_modulate(effects[0])
	find_node('Stars').speed_scale = effects[1]
	