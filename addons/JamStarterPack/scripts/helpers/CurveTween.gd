extends Tween
class_name CurveTweenUtil

signal curve_tween(sat)

@export var curve:Curve
var start =0.0
var end =1.0

func _ready():
	start_tween()
	
func start_tween(duration: float = 1.0, start_in: float = 0.0, end_in: float = 1.0):
	assert(curve, "this CurveTween neads a curve added in the inspector")
	start = start_in
	end = end_in
	tween_method(interp, 0.0, 1.0, duration).set_ease(EASE_IN).set_trans(TRANS_LINEAR)
	play()
	
func interp(sat):
	emit_signal("curve_tween",start+((end-start)*curve.interpolate(sat)))
