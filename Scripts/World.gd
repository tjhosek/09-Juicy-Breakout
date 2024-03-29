extends Node

var new_break = preload("res://Scenes/Break.tscn")
var new_pop = preload("res://Scenes/ScorePopup.tscn")
var new_Tiles = preload("res://Scenes/Tiles.tscn")
var game_over = preload("res://Scenes/GameOverPopup.tscn")
export var score = 0
export var lives = 3
export var combo = 0
onready var ball = get_node("Ball")

var comboEffects = {
	0:[Color(0,0,0),1,Color(1,1,1),1,1],
	5:[Color(.2,0,.25),1.5,Color(1,1,1),2,1.2],
	10:[Color(.5,.25,.5),2,Color(.8,.8,.8),3,1.4],
	15:[Color(.75,.5,.75),2.5,Color(.4,.4,.4),4,1.6],
	20:[Color(1,.75,1),4,Color(.25,.25,.25),5,1.8],
	30:[Color(1,.9,1),5,Color(0,0,0),10,2]
}
var scoreMult = 1

func _physics_process(delta):
	if len(get_tree().get_nodes_in_group("Tiles")) == 0:
		for i in get_tree().get_nodes_in_group("Reset"):
			i.queue_free()
		var Tiles = new_Tiles.instance()
		add_child(Tiles)
	


func increase_score(s,p):
	score += int(s*scoreMult)
	find_node("Score").update_score()
	spawn_scorePopup(p,'+'+str(s*scoreMult))
	
func decrease_lives():
	lives -= 1
	find_node("Lives").update_lives()
	if lives <= 0:
		var gameOverPopup = game_over.instance()
		gameOverPopup.position = Vector2(512,300)
		add_child(gameOverPopup)

func _unhandled_key_input(event):
	if event.pressed and event.scancode == KEY_0:
		for i in get_tree().get_nodes_in_group("Tiles"):
			i.queue_free()
		
func spawn_break(pos,col):
	var brk = new_break.instance()
	brk.position = pos
	brk.modulate = col
	brk.emitting = true
	add_child(brk)
	
func spawn_scorePopup(pos,val):
	var popup = new_pop.instance()
	popup.position = pos
	popup.txt = val
	add_child(popup)
	
func update_combo(n):
	if n == -1:
		combo = 0
	else:
		combo += n
	find_node("Combo").update_combo()
	var level = 0
	for i in comboEffects:
		if combo >= i:
			level = i
	var effects = comboEffects[level]
	var whiteList = get_tree().get_nodes_in_group("White")
	var blackList = get_tree().get_nodes_in_group("Black")
	for i in whiteList:
		i.modulate = effects[2]
	for i in blackList:
		i.modulate = effects[0]
	self.get_node("Stars").speed_scale = effects[1]
	scoreMult = effects[3]