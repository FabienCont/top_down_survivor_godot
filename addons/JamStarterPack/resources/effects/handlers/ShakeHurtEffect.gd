extends EffectHandler

static func trigger_effect(node :Node2D,_attack :AttackInterface = null)->Variant:
	CameraUtils.shake_camera(node,2.5)
	return
