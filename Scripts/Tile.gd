extends StaticBody2D

onready var sprite = get_node("Sprite")
onready var fallTween = get_node("FallTween")
onready var colorTween = get_node("ColorShift")
onready var rng = RandomNumberGenerator.new()

var coldict = {
	"RowA":Color(1,0,0),
	"RowB":Color(0,1,0),
	"RowC":Color(0,0,1),
	"RowD":Color(1,1,0),
	"RowE":Color(1,0,1)
}

var coldictTween = {
	"RowA":Color(.5,0,0),
	"RowB":Color(0,.5,0),
	"RowC":Color(0,0,.5),
	"RowD":Color(.5,.5,0),
	"RowE":Color(.5,0,.5)
}

func _ready():
	rng.randomize()
	fallTween.interpolate_property(self,'position',Vector2(position.x,-10),position,rng.randf_range(2,3),Tween.TRANS_BOUNCE,Tween.EASE_OUT)
	fallTween.start()
	var colorTweenTime = rng.randf_range(4,7)
	colorTween.interpolate_property(self,'modulate',coldict[get_parent().name],coldictTween[get_parent().name],colorTweenTime,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	colorTween.interpolate_property(self,'modulate',coldictTween[get_parent().name],coldict[get_parent().name],colorTweenTime,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,colorTweenTime)
	colorTween.start()
	for i in coldict:
		if get_parent().name == i:
			set_modulate(coldict[i])
		
func _physics_process(delta):
	pass