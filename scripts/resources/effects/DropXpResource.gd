extends EffectResource

const droppedXp = preload("res://scenes/collectables/xp.tscn")

static func trigger_effect(node :Node2D)->void:
	var droppedXpScene = droppedXp.instantiate()
	droppedXpScene.global_transform.origin = node.global_transform.origin
	node.get_parent().add_child(droppedXpScene)
	node.top_level=true
	return
