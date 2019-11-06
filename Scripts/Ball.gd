extends RigidBody2D

var maxspeed = 450

func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)
	var worldnode = get_node("/root/world")