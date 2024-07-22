extends Control

func start_new_game():
	Global.level_ind = 0
	Global.load_same_level()

func _on_new_game_btn_pressed():
	start_new_game()

func _on_exit_btn_pressed():
	get_tree().quit(0)

func _on_continue_btn_pressed():
	Global.load_same_level()

func _ready():
	$ContinueBtn.disabled = false
	if not FileAccess.file_exists(Global.save_path):
		$ContinueBtn.disabled = true
	else:
		print("LOADING")
		print(Global.stopwatch_time)
		Global.load_save()
		print(Global.stopwatch_time)
		if Global.stopwatch_time==0:
			$ContinueBtn.disabled = true
