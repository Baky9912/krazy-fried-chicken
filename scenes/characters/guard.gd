extends Area2D

@onready var path_follow = get_parent()
@export var speed : int = 16
var target_framerate = 60
var dying = false
var oldmarkx : float = 0

func set_speed(x: int):
	speed = x

func _on_body_entered(body):
	print("guard collided")
	if body.is_in_group("Player"):
		body.get_hit(self)
	
func _physics_process(delta):
	if dying:
		return
	if speed==0:
		$AnimatedSprite2D.play("0idle")
	else:
		$AnimatedSprite2D.play("run")
	if path_follow.is_in_group("Paths"):
		path_follow.progress += speed * delta
	turn()
	
func turn():
	if oldmarkx < global_position.x:
		$AnimatedSprite2D.flip_h = false
	elif oldmarkx > global_position.x:
		$AnimatedSprite2D.flip_h = true
	oldmarkx = global_position.x

func freeze_in_time():
	print("frezzing")
	var old_speed = speed
	speed = 0
	await get_tree().create_timer(1).timeout
	speed = old_speed
	

func _ready():
	$AnimatedSprite2D.play("run")
