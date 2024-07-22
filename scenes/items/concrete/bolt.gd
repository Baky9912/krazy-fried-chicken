extends Item
class_name Bolt

var speed_increase : float

func use_over():
	speed_increase = player.speed * 0.85
	player.speed += speed_increase
	
func effect_over():
	var step = 30.0
	for i in step:
		await get_tree().create_timer(0.1).timeout
		player.speed -= speed_increase / step
	emit_signal("item_undone")
