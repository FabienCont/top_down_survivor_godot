extends Label

var game_clock :GameClock

func _process(_delta: float) -> void:
	_update_display_time()

func _update_display_time() -> void :
	var time = game_clock.time
	var second = str(floor(fmod(time,60)))
	var minutes = str(floor(time/60))
	
	if second.length() == 1:
		second = "0" + second
	if minutes.length() == 1:
		minutes = "0" + minutes
	text= minutes + ":" + second
