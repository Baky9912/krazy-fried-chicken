extends Area2D
class_name Item

signal item_used
signal item_undone

@export var MAX_USES = 0
var uses = 0
var player : Protagonist = null

func use():
	await use_over()
	add_use()

func use_over():
	print(player, "using generic item")

func add_use():
	emit_signal("item_used")
	uses += 1
	if uses >= MAX_USES:
		player.item = null
		$Sprite2D.set_visible.call_deferred(false)
		await item_undone
		print("queue free called on Item")
		queue_free()

func effect():
	await effect_over()
	emit_signal("item_undone")

func effect_over():
	pass

func _on_body_entered(body: Protagonist):
	print(self)
	get_parent().remove_child.call_deferred(self)
	await self.tree_exited
	$CollisionShape2D.set_disabled.call_deferred(true)
	if body.item:
		# free the unused item
		body.item.queue_free()
	body.item = self
	self.apply_scale.call_deferred(Vector2(0.7, 0.7))
	# $Sprite2D.set_offset.call_deferred(Vector2(0, -400))
	print(self.position)
	self.set_position.call_deferred(Vector2(0, 0))
	print(body.position)
	body.add_child.call_deferred(self)
	await self.tree_entered
	player = body
	print("Waited")
