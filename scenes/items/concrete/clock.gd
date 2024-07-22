extends Item
class_name Clock

var guards = null
var speeds = null

func use_over():
	# player.get_parent().get_tree().call_group("guards", "freeze_in_time")
	guards = player.get_parent().get_tree().get_nodes_in_group("guards")
	print("len(guards)=", len(guards))
	speeds = []
	speeds.resize(len(guards))
	for i in len(guards):
		speeds[i] = guards[i].speed
		guards[i].speed = 0
		
func effect_over():
	await get_tree().create_timer(1).timeout
	for i in len(guards):
		guards[i].speed = speeds[i]
