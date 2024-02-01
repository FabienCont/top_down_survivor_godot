extends HurtEffectHandler

const attackDamageParticule = preload("res://scenes/particles/AttackDamageParticule.tscn")

static func trigger_effect(node :Node2D,_attack :Attack)->void:
	CameraUtils.shake_camera(node,2.5)
	return
