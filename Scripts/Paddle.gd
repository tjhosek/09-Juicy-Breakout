extends KinematicBody2D


var new_ball = preload("res://Scenes/Ball.tscn")
onready var elastic_tween = get_node("ElasticTween")
var tweenMaxSpeed = 4000
var tweenMinSpeed = 40
var tweenMaxScale = 1.5
var tweenMinScale = .5
var tweenTime = .1



func _ready():
	set_process_input(true)
	
func _physics_process(delta):
	var mouse_x = get_viewport().get_mouse_position().x
	elastic_tween.interpolate_property(self, "scale", Vector2(4,.2), Vector2(1,1), 1, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
	elastic_tween.start()
	position = Vector2(mouse_x, position.y)
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if not get_parent().has_node("Ball") and get_parent().lives > 0:
			var ball = new_ball.instance()
			ball.position = position - Vector2(0,32)
			ball.name = "Ball"
			ball.linear_velocity = Vector2(200,-200)
			get_parent().add_child(ball)