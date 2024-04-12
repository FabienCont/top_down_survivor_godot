extends EffectHandler

static func trigger_effect(node :Node2D,_data = null)-> Variant:
	if node.sprite_component:
		var tween = node.create_tween().set_ease(Tween.EASE_IN)
		tween.tween_property(node.sprite_component,"modulate:a",0.0,0.6).from_current()
	return
