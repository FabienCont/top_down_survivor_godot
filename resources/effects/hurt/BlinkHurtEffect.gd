extends EffectHandler

static func trigger_effect(node :Node2D,_attack :AttackInterface = null)->Variant:
	if node.sprite_component ==null :
		return
	var sprite = node.sprite_component
	var tween = node.create_tween()
	tween.set_parallel(false)
	tween.tween_property(sprite,"modulate:v",3,0.1)
	tween.tween_property(sprite,"modulate:v",1,0.1)
	return
	
