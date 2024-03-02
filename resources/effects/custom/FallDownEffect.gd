extends EffectHandler

static func trigger_effect(node :Node2D,_data = null)-> Variant:
	var tween = node.create_tween().set_ease(Tween.EASE_OUT)
	var new_position = node.position + Vector2(0,8)
	tween.tween_property(node,"position",new_position,0.1).from_current()
	return
