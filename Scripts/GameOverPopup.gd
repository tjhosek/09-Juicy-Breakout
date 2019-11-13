extends Node2D

onready var enterTween = get_node("Tween")

func _ready():
	enterTween.interpolate_property(self,"position",Vector2(position.x,-30),position,2,Tween.TRANS_BOUNCE,Tween.EASE_OUT)
	enterTween.start()


func _on_Retry_pressed():
	get_tree().reload_current_scene()


func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")


func _on_Quit_pressed():
	get_tree().quit()
