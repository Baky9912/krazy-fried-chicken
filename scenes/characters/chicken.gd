extends Area2D

@onready var path_follow = get_parent()
@export var speed : int = 16
var target_framerate = 60
var dying = false
@onready var oldmarkx : float = global_position.x

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
	print("chicken dying")
	dying = true
	speed = 0
	$AnimatedSprite2D.play("caught")
	await $AnimatedSprite2D.animation_finished
	body.catch_chicken(self)
	queue_free()

func _physics_process(delta):
	if dying:
		return
	if speed==0:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("run")
	if path_follow.is_in_group("Paths"):
		path_follow.progress += speed * delta
	turn()
	
func turn():
	if oldmarkx < global_position.x:
		$AnimatedSprite2D.flip_h = true
	elif oldmarkx > global_position.x:
		$AnimatedSprite2D.flip_h = false
	oldmarkx = global_position.x

func _ready():
	$AnimatedSprite2D.play("run")
