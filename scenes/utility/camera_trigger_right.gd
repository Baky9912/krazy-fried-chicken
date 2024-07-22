extends Area2D

@onready var cam_scale_out = get_parent().right_zoom
@onready var path = "../" + get_parent().path
@onready var cam_offset = get_parent().right_offset

func _on_body_exited(_body):
	var cam : Camera2D = get_node(path)
	cam.zoom = cam_scale_out * Vector2.ONE
	cam.offset = cam_offset
	print("Set camera zoom ", cam.zoom)
