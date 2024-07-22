extends Item
class_name Feather

var gravity_increase : float
var speed_increase : float

func use_over():
	gravity_increase = -player.gravity_pull * 0.5
	player.gravity_pull += gravity_increase
	speed_increase = player.speed * 0.25
	player.speed += speed_increase

func effect_over():
	var step = 30.0	
	for i in step:
		await get_tree().create_timer(0.1).timeout
		player.speed -= speed_increase / step
		player.gravity_pull -= gravity_increase / step
	emit_signal("item_undone")
