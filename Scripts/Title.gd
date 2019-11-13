extends Node2D

onready var tweenNode = get_node("Tween")
var menuRotate = deg2rad(5)
var tweenTrans = Tween.TRANS_CUBIC
var tweenTime = 1.5


func _ready():
	tweenNode.interpolate_property(self,"rotation",rotation-menuRotate,rotation+menuRotate,tweenTime,tweenTrans,Tween.EASE_IN_OUT)
	tweenNode.interpolate_property(self,"rotation",rotation+menuRotate,rotation-menuRotate,tweenTime,tweenTrans,Tween.EASE_IN_OUT,tweenTime)
	tweenNode.start()