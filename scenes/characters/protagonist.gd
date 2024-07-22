class_name Protagonist
extends CharacterBody2D

@export var original_speed = 250
@export var original_jump_height = 450
@export var gravity_pull = 20
@onready var speed = original_speed
@onready var jump_height = original_jump_height
var max_jumps = 2
var target_fps = 60
var buffered_jump = false
var jumps = 0
var dir_x = 0
var chickens = 0
var item : Item = null # Clock.new()
var outside_control: MovementController = MovementController.new(0, 0, 0, Vector2(0,0))
var inside_control: Vector2 = Vector2.ZERO
@onready var old_pos: Vector2 = self.position


func _unhandled_input(_event):
	dir_x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	buffered_jump = Input.is_action_just_pressed("ui_up")
	if Input.is_action_just_pressed("ui_down"):
		gravity_pull *= 2.5
	if Input.is_action_just_released("ui_down"):
		gravity_pull /= 2.5
	if Input.is_action_just_pressed("use_item"):
		use_item()
	if Input.is_action_just_pressed("restart_level"):
		Global.load_same_level()
	
func _physics_process(delta):
	# print(jumps, "/", max_jumps)
	#var correction_x = min(35 * delta, abs(speed - original_speed)) * sign(speed - original_speed)
	#speed -= correction_x
	
	#var correction_y = min(50 * delta, abs(jump_height - original_jump_height)) * sign(jump_height - original_jump_height)
	#jump_height -= correction_y
	# auto correct to original ^
	
	
	inside_control.x = dir_x * speed * delta * target_fps
	if buffered_jump and jumps < max_jumps:
		inside_control.y = -jump_height * delta * target_fps
		buffered_jump = false
		jumps += 1
	inside_control.y += gravity_pull * delta * target_fps
	
	if is_on_floor() and inside_control.y > 0:
		inside_control.y = 0
	if is_on_floor() and inside_control.y==0:
		jumps = 0
	if is_on_ceiling():
		inside_control.y += 2500*delta
	
	velocity = outside_control.velocity + inside_control
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = dir_x < 0
	
	var new_anim : String
	if velocity.y > 0:
		new_anim = "fall"
	elif velocity.y < 0:
		new_anim = "jump"
	elif velocity.x == 0:
		new_anim = "idle"
	else:
		new_anim = "run"
	$AnimatedSprite2D.play(new_anim)
	
	#print("speed ", speed)
	#print("jump_height ", jump_height)
	outside_control.lose_speed(delta)
	move_and_slide()

func _process(_delta):
	if not get_parent().get("min_height") == null:
		if position.y >= get_parent().min_height:
			get_hit(self)

func use_item():
	if item != null:
		item.player = self
		item.use()

func add_outside_control(mc: MovementController):
	if outside_control:
		outside_control.queue_free()
	outside_control = mc
	
func catch_chicken(_chicken):
	chickens += 1
	print(chickens)

func get_hit(_hitter):
	print("game over")
	speed = 0
	jump_height = 0
	Global.load_lose_menu()

func _ready():
	$AnimatedSprite2D.animation = "idle"
