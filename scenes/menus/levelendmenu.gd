extends Control

func float_to_time(timef: float) -> String:
	var time: int = int(timef)
	var s = int(time%60)
	var m = int	((time-s)/60%60)
	var h = int((time-m*60-s)/3600)
	var decis = int((timef - h*3600-m*60-s) * 10)
	if h>0:
		return "%d:%02d:%02d:%01d" % [h, m, s, decis]
	else:
		return "%02d:%02d:%01d" % [m, s, decis]

func _on_next_level_menu_pressed():
	Global.load_same_level()

func _on_main_menu_btn_pressed():
	Global.load_main_menu()

func _ready():
	Global.level_ind += 1
	if Global.game_beaten():
		get_node("CongratsLbl").visible = true
		get_node("NextLevelMenu").disabled = true
	else:
		get_node("CongratsLbl").visible = false
		get_node("NextLevelMenu").disabled = false
	$TimerLbl.text = float_to_time(Global.stopwatch_time)
	if Global.game_beaten():
		print("Game beaten, resetting stats")
		Global.level_ind = 0
		Global.stopwatch_time = 0
	Global.save()
