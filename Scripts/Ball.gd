extends RigidBody2D

var maxspeed = 450
onready var JiggleTween = get_node("Jiggle")
export var breakColor = Color(0,0,0)


signal lives
signal score

func _ready():
	contact_monitor = true
	set_max_contacts_reported(6)
	var WorldNode = get_node("/root/World")
	connect("score", WorldNode, "increase_score")
	connect("lives", WorldNode, "decrease_lives")
	
func _physics_process(delta):
	var b = get_colliding_bodies()
	for i in b:
		if i.is_in_group("Tiles"):
			emit_signal("score",10)
			i.queue_free()
			breakColor = i.modulate
		Jiggle(3,.1,1.5)
			
	if position.y > get_viewport_rect().end.y:
		queue_free()
		emit_signal("lives")
		
func Jiggle(n,t,x):
	if not JiggleTween.is_active():
		for i in n:
			JiggleTween.interpolate_property(self, 'scale', scale, Vector2(x,x), t,Tween.TRANS_ELASTIC,Tween.EASE_IN_OUT,2*i*t)
			JiggleTween.interpolate_property(self, 'scale', Vector2(x,x),scale, t,Tween.TRANS_ELASTIC,Tween.EASE_IN_OUT,2*i*t+t)
		JiggleTween.start()
	else:
		JiggleTween.reset_all()