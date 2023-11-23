extends EffectHandler

const droppedXp = preload("res://scenes/collectables/xp.tscn")

static func trigger_effect(node :Node2D)->void:
	var droppedXpScene = droppedXp.instantiate()
	droppedXpScene.global_transform.origin = node.global_transform.origin
	var parent = node.get_parent()
	parent.call_deferred("add_child",droppedXpScene)
	droppedXpScene.top_level=true
	var tween = parent.create_tween().set_ease(Tween.EASE_OUT)
	var new_position = droppedXpScene.position + Vector2(0,10)
	tween.tween_property(droppedXpScene,"position",new_position,0.2).from_current()
	return
