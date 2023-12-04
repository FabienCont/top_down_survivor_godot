extends HurtEffectHandler

const particules = preload("res://scenes/particles/ThrowParticleHurtEffect.tscn")

static func trigger_effect(node :Node2D,attack :Attack)->void:
	var scene: GPUParticles2D = particules.instantiate()
	scene.one_shot=true
	scene.emitting=true
	node.add_child(scene)
	scene.global_transform.origin = attack.attack_position
	
