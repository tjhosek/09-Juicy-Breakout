extends KinematicBody2D


var new_ball = preload("res://Scenes/Ball.tscn")
onready var elastic_tween = get_node("ElasticTween")
var tweenMaxSpeed = 3000
var tweenMinSpeed = 40
var tweenMaxScale = 1.5
var tweenMinScale = .5
var tweenTime = .1


func _ready():
	set_process_input(true)
	
func _physics_process(delta):
	var mouse_x = get_viewport().get_mouse_position().x
	#elastic_tween.interpolate_property(self, "scale", Vector2(1.5,.5), Vector2(1,1), 1, Tween.TRANS_QUART, Tween.EASE_OUT)
	#elastic_tween.start()
	position = Vector2(mouse_x, position.y)
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if not get_parent().has_node("Ball"):
			var ball = new_ball.instance()
			ball.position = position - Vector2(0,32)
			ball.name = "Ball"
			ball.linear_velocity = Vector2(200,-200)
			get_parent().add_child(ball)
			
	if event is InputEventMouseMotion:
		#print(Input.get_last_mouse_speed())
		var mouseSpeed = abs(Input.get_last_mouse_speed().x)
		if mouseSpeed > tweenMaxSpeed:
			elastic_tween.interpolate_property(self, "scale", scale, Vector2(tweenMaxScale,tweenMinScale), tweenTime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elif mouseSpeed > tweenMinSpeed:
			var xn = (tweenMaxScale-1)*(mouseSpeed-tweenMinSpeed)/(tweenMaxSpeed-tweenMinSpeed)+1
			var yn = 1-(tweenMinScale-1)*(mouseSpeed-tweenMaxSpeed)/(tweenMaxSpeed-tweenMinSpeed)
			print(str(xn) + ',' + str(yn))
			elastic_tween.interpolate_property(self, "scale", scale, Vector2(xn,yn), tweenTime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		else:
			elastic_tween.interpolate_property(self, "scale", scale, Vector2(1,1), tweenTime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elastic_tween.start()