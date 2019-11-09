extends Label

func _ready():
	update_combo()
	
func update_combo():
	text = str(get_parent().combo)