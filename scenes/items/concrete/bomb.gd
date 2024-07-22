extends Item
class_name Bomb

var bomb_strength = 1300
var vertical_bias = 1.6
var blast_radius = 200

func use_over():
	# place it where the gamer is standing
	# save coords
	get_parent().remove_child.call_deferred(self)
	await self.tree_exited
	player.add_sibling.call_deferred(self)
	await self.tree_entered
	$Sprite2D.set_visible.call_deferred(true)
	self.set_position.call_deferred(player.position - Vector2(2, 2))
	self.apply_scale.call_deferred(Vector2(1.2, 1.2))
	await get_tree().create_timer(0.1).timeout
	print("USE DONE")
	#self.set_position.call_deferred(Vector2(100,100))
	

func effect_over():
	print("EFFECT STARTED")
	#print("BOMB POS ", bomb_pos)
	var under_bomb = make_bomb()
	player.add_sibling.call_deferred(under_bomb)
	await under_bomb.tree_entered
	under_bomb.visible = true
	# $CollisionShape2D.set_disabled.call_deferred(false)
	$Sprite2D.set_visible.call_deferred(true)
	$Sprite2D.modulate = Color.RED
	under_bomb.z_index = 0
	self.z_index = 1
	var step = 30.0
	var length = 1
	for i in step:
		print("MODULATING")
		$Sprite2D.modulate.a = (i+1)/step
		await player.get_tree().create_timer(length/step).timeout
	# calculate how fast player should be laucnhed and modify velocity
	length = 0.7
	step = 5
	under_bomb.visible = false
	for i in step:
		apply_scale(Vector2(1.07, 1.07))
		#$Sprite2D.apply_scale()
		#$Sprite2D.position -= Vector2(0, 1)
		position -= Vector2(0, 1.2)
		if i%2==0:
			$Sprite2D.modulate = Color.RED
		else:
			$Sprite2D.modulate = Color.WHITE
		await get_tree().create_timer(length/step).timeout
	print("About to explode")
	
	# debug_prints()
	await explode()
	
func debug_prints():
	var cr = ColorRect.new()
	cr.color = Color.GREEN
	cr.position = self.position + Vector2(11,15)
	cr.set_size(Vector2(1,1))
	player.add_sibling(cr)
	cr.z_index = 4
	
	var cr2 = ColorRect.new()
	cr2.color = Color.RED
	cr2.position = player.position + Vector2(0,-2)
	cr2.set_size(Vector2(1,1))
	player.add_sibling(cr2)
	cr2.z_index = 4


func make_bomb() -> Sprite2D:
	var new_bomb = Sprite2D.new()
	new_bomb.texture = preload("res://assets/items/bomb64.png")
	new_bomb.apply_scale(Vector2(0.422 * 0.7 * 1.2, 0.422 * 0.7 * 1.2))
	new_bomb.position = Vector2(8, 6) + position
	new_bomb.visible = false
	print(new_bomb.position, "NEW BOMB POS")
	return new_bomb

func explode():
	var player_center = player.position + Vector2(0,-2)
	var bomb_center = self.position + Vector2(11, 15)
	var dist = bomb_center.distance_to(player_center) 
	var mult: float
	print("DISTANCE: ", dist)
	if dist < blast_radius:
		mult = dist/blast_radius
	else: return
	var dir = (player_center-bomb_center).normalized()
	if dir.y < 0:
		dir.y *= 1.6
		dir = dir.normalized()
	var explosion_speedup = (bomb_strength*mult + bomb_strength) * dir
	# linear_loss, mult_loss, length, velocity
	print("EXPLOSION SPEEDUP ", explosion_speedup)
	var m = MovementController.new(bomb_strength, 0, 1, explosion_speedup)
	player.add_outside_control(m)
	print("Exploded")
	

