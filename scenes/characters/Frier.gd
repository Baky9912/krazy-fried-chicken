extends Area2D

@export var NEEDED_CHICKENS = 1

func _on_body_entered(body):
	if body.chickens >= NEEDED_CHICKENS:
		Global.load_win_menu()
	else:
		$Label.text = "%d/%d" % [body.chickens, NEEDED_CHICKENS]
		await get_tree().create_timer(3).timeout
		$Label.text = ""
		
func _ready():
	$Label.text = ""
