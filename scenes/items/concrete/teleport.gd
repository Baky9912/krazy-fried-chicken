extends Item
class_name Teleport

@export var landing : Vector2

func use_over():
	player.set_position.call_deferred(landing)
	
func effect_over():
	# animate
	pass
