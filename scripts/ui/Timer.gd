extends Label

var start_time = 0.0

func _process(delta: float) -> void:
	start_time = start_time + delta
	var second = str(floor(fmod(start_time,60)))
	var minutes = str(floor(start_time/60))
	
	if second.length() == 1:
		second = "0" + second
	if minutes.length() == 1:
		minutes = "0" + minutes
	text= minutes + ":" + second
