extends Node2D

var initSpeed = 20
onready var spinTween = get_node("Spinout")
var colIndex = 0
var txt = ''

var colList = [
	Color(1,0,0),
	Color(1,.5,0),
	Color(1,1,0),
	Color(0,1,0),
	Color(0,0,1),
	Color(.25,0,.5),
	Color(.5,0,.5),
	Color(1,0,1)
]

func _ready():
	get_node("Label").text = txt
	spinTween.interpolate_property(self,'rotation',get_rotation(),780,3,Tween.TRANS_EXPO,Tween.EASE_IN,1)
	spinTween.interpolate_property(self,'position',position,Vector2(position.x,-10),2,Tween.TRANS_EXPO,Tween.EASE_IN)
	spinTween.start()
	

func _physics_process(delta):
	if colIndex < len(colList)-1:
		colIndex += 1
	else:
		colIndex = 0
	modulate = colList[colIndex]
	
	if position.y <= -10:
		queue_free()