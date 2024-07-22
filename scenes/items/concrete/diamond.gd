extends Item
class_name Diamond

var old_2

func use_over():
	print("DIAMOND")
	old_2 = 2 & player.collision_layer
	player.collision_layer &= ~old_2
	player.modulate = Color8(220, 70, 70)

func effect_over():
	await get_tree().create_timer(0.7).timeout
	player.collision_layer |= old_2
	player.modulate = Color.WHITE
