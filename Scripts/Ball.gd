extends RigidBody2D

var maxspeed = 450
onready var JiggleTween = get_node("Jiggle")
onready var WorldNode = get_node("/root/World")
onready var sprite = get_node("Sprite")
var breakColor = Color(0,0,0)

signal lives
signal score
signal combo

func _ready():
	contact_monitor = true
	set_max_contacts_reported(6)
	connect("score", WorldNode, "increase_score")
	connect("lives", WorldNode, "decrease_lives")
	connect("combo",WorldNode,"update_combo")
	
func _physics_process(delta):
	var b = get_colliding_bodies()
	for i in b:
		if i.is_in_group("Tiles"):
			emit_signal("score",10,i.position)
			emit_signal("combo",1)
			WorldNode.spawn_break(i.position,i.modulate)
			i.queue_free()
		elif i.is_in_group("Paddle"):
			emit_signal("combo",0)
		JiggleTween.interpolate_property(self,'scale',Vector2(2,2),Vector2(1,1),.5,Tween.TRANS_QUART,Tween.EASE_OUT)
		JiggleTween.start()
			
	if position.y > get_viewport_rect().end.y:
		queue_free()
		emit_signal("lives")
		emit_signal("combo",-1)
		
func Jiggle(n,t,x):
	if not JiggleTween.is_active():
		for i in n:
			JiggleTween.interpolate_property(self, 'scale', scale, Vector2(x,x), t,Tween.TRANS_ELASTIC,Tween.EASE_IN_OUT,2*i*t)
			JiggleTween.interpolate_property(self, 'scale', Vector2(x,x),scale, t,Tween.TRANS_ELASTIC,Tween.EASE_IN_OUT,2*i*t+t)
		JiggleTween.start()
	else:
		JiggleTween.reset_all()