extends Particles2D

onready var timer = get_node("Timer")

func _ready():
	timer.wait_time = lifetime
	timer.start(lifetime)
	#queue_free()