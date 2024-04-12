extends EffectHandler

const particules = preload("./../../../particules/attack/ThrowParticleHurtEffect.tscn")

static func trigger_effect(node :Node2D,attack = null)->Variant:
	var scene: GPUParticles2D = particules.instantiate()
	scene.one_shot=true
	scene.emitting=true
	node.add_child(scene)
	scene.global_transform.origin = attack.attack_position
	return
