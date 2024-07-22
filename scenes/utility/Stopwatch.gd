extends Label

func float_to_time(timef: float) -> String:
	var time: int = int(timef)
	var s = int(time%60)
	var m = int((time-s)/60%60)
	var h = int((time-m*60-s)/3600)
	var decis = int((timef - h*3600-m*60-s) * 10)
	if h>0:
		return "%d:%02d:%02d:%01d" % [h, m, s, decis]
	else:
		return "%02d:%02d:%01d" % [m, s, decis]

func _process(delta):
	Global.stopwatch_time += delta
	text = float_to_time(Global.stopwatch_time)


