extends StaticBody2D

onready var sprite = get_node("Sprite")

var coldict = {
	"RowA":Color(255,0,0),
	"RowB":Color(0,255,0),
	"RowC":Color(0,0,255),
	"RowD":Color(255,255,0),
	"RowE":Color(255,0,255)
}

func _ready():
	for i in coldict:
		if get_parent().name == i:
			sprite.set_modulate(coldict[i])
		
	