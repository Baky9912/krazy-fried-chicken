extends Item
class_name FrogJuice

func use_over():
	player.max_jumps += 1
	
func effect_over():
	await get_tree().create_timer(1.5).timeout
	player.max_jumps -= 1
