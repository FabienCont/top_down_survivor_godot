extends EffectHandler

const item: Item = preload("res://resources/items/consumable/xp.tres") 

static func trigger_effect(node :Node2D,_data = null):
	var droppedXpScene: Collectable = ItemHelper.create_collectable(item)
	droppedXpScene.global_transform.origin = node.global_transform.origin
	droppedXpScene.top_level=true
	var parent = node.get_parent()
	parent.call_deferred("add_child",droppedXpScene)
	
	var random_x=randi_range(-12,12)
	var random_y=randi_range(0,5)
	var jump_position = droppedXpScene.position + Vector2(0+random_x/2.0,-15+random_y)
	var end_position = droppedXpScene.position + Vector2(0+random_x,5)
	var tween = parent.create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.set_parallel(false)
	tween.tween_property(droppedXpScene,"position",jump_position,0.2).from_current()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(droppedXpScene,"position",end_position,0.6).from(jump_position)
	return
