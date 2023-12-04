extends HurtEffectHandler

static func trigger_effect(node :Node2D,_attack :Attack)->void:
	if node.sprite ==null :
		return
	var sprite = node.sprite
	var tween = node.create_tween()
	tween.set_parallel(false)
	tween.tween_property(sprite,"modulate:v",3,0.1)
	tween.tween_property(sprite,"modulate:v",1,0.1)
	
