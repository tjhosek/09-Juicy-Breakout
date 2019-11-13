extends Label

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
onready var colorTween = get_node("ColorTween")
var tweenTime = 1

func _ready():
	pass