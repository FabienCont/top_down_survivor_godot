extends HurtEffectResource

const attackDamageParticule = preload("res://scenes/particles/AttackDamageParticule.tscn")

static func trigger_effect(node :Node2D,attack :Attack)->void:
	CameraUtils.shake_camera(node,2.5)
	return
